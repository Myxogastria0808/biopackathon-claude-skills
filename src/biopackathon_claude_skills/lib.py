def calc_total_price(price: float, tax_rate: float = 0.10) -> float:
    """Return the total price with consumption tax included.

    Args:
        price (float): The price before tax.
        tax_rate (float): The consumption tax rate to apply. Must be
            either 0.08 or 0.10. Defaults to 0.10.

    Returns:
        float: The total price with consumption tax included.

    Raises:
        ValueError: If ``tax_rate`` is not 0.08 or 0.10.
    """
    if tax_rate not in (0.08, 0.10):
        raise ValueError("tax_rate must be 0.08 or 0.10")
    return price * (1 + tax_rate)

