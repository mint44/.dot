def transparentize(hex):
    # 20% transparent a hex, return a new hex
    hex = hex.lstrip('#')
    rgb = tuple(int(hex[i:i+2], 16) for i in (0, 2, 4))
    return '#%02x%02x%02x' % (int(rgb[0]*0.4), int(rgb[1]*0.4), int(rgb[2]*0.4))


