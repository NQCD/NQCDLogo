using Luxor

px = 300
linewidth = px/30

function gradient(p1, p2)
    diff = p1 - p2
    return diff[2] / diff[1]
end

topleft = Point(-px, -px)
topright = Point(px, -px)
term1 = Point(-px/4+px/30, px/3)
term2 = Point(px/4-px/30, px/3)
apex = Point(0, 0+px/5)

A = Point(-0.9px, px/3)
B = Point(-2/3*px-4*px/30, px)
grad1 = gradient(term1, B)
grad2 = -grad1

x = px/30*8
C = term2 + Point(x, x*grad2)
D = Point(4/3*px, 0)

x = px/10
mid1 = term1 + Point(x, x*grad1)
mid2 = term2 - Point(x, x*grad2)

topanchor1 = Point(-px/2, -px)
topanchor2 = Point(px/2, -px)

linecolor = "white"

internal = px/15
long = px/3
short = px/30*8

function drawlogo()
    setline(linewidth)
    rounding = 0.4
    squircle(Point(0, 0), px, px, rt=rounding, :clip)
    background(Luxor.julia_blue...)

    move(topleft)
    curve(A, B, term1)
    curve(mid1, apex + Point(-px/15, 0), apex)
    curve(apex + Point(-short, 0), topanchor1 + Point(internal, long), topanchor1)
    line(topleft)
    sethue(Luxor.julia_red)
    fillpreserve()
    sethue(linecolor)
    strokepath()

    move(topright)
    curve(D, C, term2)
    curve(mid2, apex + Point(px/15, 0), apex)
    curve(apex + Point(short, 0), topanchor2 + Point(-internal, long), topanchor2)
    line(topright)
    sethue(Luxor.julia_purple)
    fillpreserve()
    sethue(linecolor)
    strokepath()

    move(topanchor1)
    line(topanchor2)
    curve(topanchor2 + Point(-internal, long), apex + Point(short, 0), apex)
    curve(apex + Point(-short, 0), topanchor1 + Point(internal, long), topanchor1)
    sethue(Luxor.julia_green)
    fillpreserve()
    sethue(linecolor)
    strokepath()

    clipreset()
    sethue(linecolor)
    squircle(Point(0, 0), px, px, rt=rounding, :stroke)
end

function addtext()
    fontface("Fira Sans")
    fontsize(linewidth*12)
    text("NQCD", Point(-px/4, 2px/3), valign=:middle, halign=:left)
end

Drawing(2px+linewidth, 2px+linewidth, :png, "images/logo_with_text.png")
background(1, 1, 1, 0)
origin()

drawlogo()
addtext()

finish()
preview()
