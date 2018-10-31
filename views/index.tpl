% rebase("base.tpl", title="Store")
<section class="products-view">
    % for product in products:
    <figure class="product" id="{{product['name'].lower()}}">
        <figcaption>{{product["name"]}}</figcaption>
        <img src="/static/img/{{product['img']}}">
        <span class="verð">isk{{product["price"]}}</span>
    </figure>
    % end
</section>
