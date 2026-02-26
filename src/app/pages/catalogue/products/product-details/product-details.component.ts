import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ProductService } from '../services/product.service';

@Component({
  selector: 'ngx-product-details',
  templateUrl: './product-details.component.html',
  styleUrls: ['./product-details.component.scss']
})
export class ProductDetailsComponent implements OnInit {
  product: any = {};

  constructor(
    private activatedRoute: ActivatedRoute,
    private productService: ProductService,
    private router: Router,
  ) {
  }

  ngOnInit() {
    const id = this.activatedRoute.snapshot.paramMap.get('id');
    // Use v2 product endpoint directly - definition endpoint doesn't exist
    this.productService.getProductById(id)
      .subscribe(res => {
        // Flatten nested structure to match form expectations
        this.product = {
          ...res,
          // Extract price as number from inventory
          price: res.inventory?.prices?.[0]?.finalPrice 
            ? parseFloat(res.inventory.prices[0].finalPrice.replace(/[^0-9.]/g, ''))
            : res.inventory?.price 
            ? parseFloat(res.inventory.price.replace(/[^0-9.]/g, ''))
            : null,
          quantity: res.inventory?.quantity,
          // Convert single description object to descriptions array
          descriptions: res.description ? [res.description] : [],
        };
      });
  }

  route(link) {
    this.router.navigate(['pages/catalogue/products/' + this.product.sku + '/' + link]);
  }

}
