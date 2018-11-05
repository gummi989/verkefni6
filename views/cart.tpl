
% import itertools

% rebase("base.tpl", title="Cart")

<table class="table table-hover products-in-cart">

    <thead>

        <tr>

            <th>Nafn</th>

            <th>Verð</th>

            <th>Magn</th>

            <th>Tæma körfu</th>

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

        if product is not None:  

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

            ISK{{product["price"]}}

        </td>

        <td class="qty">

            {{qty}}

        </td>

        <td class="remove">

            <a href="/cart/remove?pid={{pid}}">Eyða</a>

        </td>

    </tr>

        % end

    % end

    </tbody>

    <tfoot>

        <tr>

            <th colspan="2">Samtals</th>

            <td>ISK{{total_price}}</td>

            <td>{{total_qty}}</td>

            <td>

                <a href="/cart/empty">Tæma körfu</a>

            </td>

        </tr>

    </tfoot>

</table>

<nav>

    <a href="/" class="button back">

        <img src="/static/img/back.svg" alt="Back">

    </a>

</nav>
