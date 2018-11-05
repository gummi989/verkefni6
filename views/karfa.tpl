
% import itertools

% rebase("base.tpl", title="Cart")

<table class="table table-hover products-in-cart">

    <thead>

        <tr>

            <th>Image</th>

            <th>Name</th>

            <th>Price</th>

            <th>Quantity</th>

            <th>Remove</th>

        </tr>

    </thead>

    <tbody>

    <%

    cart = sorted(cart)

    cart = [(key, sum(1 for _ in group)) for key, group in itertools.groupby(cart)]

    total_price = 0

    total_qty = 0

    for pid, qty in cart:

        product = products.get(pid)

        if product is not None:  # If no product with the specified ID is found, don't show it

            total_price += product["price"]

            total_qty += qty

    %>

    <tr>

        <td class="img">

            <img src="/static/img/{{product['img']}}">

        </td>

        <td class="name">

            {{product["name"]}}

        </td>

        <td class="price">

            &euro;{{product["price"]}}

        </td>

        <td class="qty">

            {{qty}}

        </td>

        <td class="remove">

            <a href="/cart/remove?pid={{pid}}">Remove</a>

        </td>

    </tr>

        % end

    % end

    </tbody>

    <tfoot>

        <tr>

            <th colspan="2">Total</th>

            <td>&euro;{{total_price}}</td>

            <td>{{total_qty}}</td>

            <td>

                <a href="/cart/empty">Empty cart</a>

            </td>

        </tr>

    </tfoot>

</table>

<nav>

    <a href="/" class="button back">

        <img src="/static/img/back.svg" alt="Back">

    </a>

</nav>
