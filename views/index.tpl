% rebase("base.tpl", title="Store")

<section class="products-view">

    % for pid, product in products.items():

    <a href="/cart/add?pid={{pid}}">

        <figure class="product" id="{{product['name'].lower()}}">

            <figcaption>{{product["name"]}}</figcaption>

            <img src="/static/img/{{product['img']}}">

            <span class="price">&ISK;{{product["price"]}}</span>

        </figure>

    </a>

    % end

</section>

<nav class="topnav">

    <a href="/cart" class="button cart">

        <span class="no-of-items">{{len(cart)}}</span>

        <img src="/static/img/cart.svg" alt="Cart">

    </a>
</nav>
