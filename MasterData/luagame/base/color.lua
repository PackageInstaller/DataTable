local setmetatable = _ENV.setmetatable
local _floor = math.floor
local type = _ENV.type
local Mathf = UnityEngine.Mathf
local Math = require("base.mathx")
local Color = {}
Color.__index = Color

function Color.__call(t, r, g, b, a)
  return setmetatable({
    r = r or 0,
    g = g or 0,
    b = b or 0,
    a = a or 1
  }, Color)
end

function Color.New(r, g, b, a)
  return setmetatable({
    r = r or 0,
    g = g or 0,
    b = b or 0,
    a = a or 1
  }, Color)
end

function Color:Set(r, g, b, a)
  self.r = r
  self.g = g
  self.b = b
  self.a = a or 1
end

function Color:Get()
  return self.r, self.g, self.b, self.a
end

function Color:Equals(other)
  return self.r == other.r and self.g == other.g and self.b == other.b and self.a == other.a
end

function Color.Lerp(a, b, t)
  t = Math.Clamp01(t)
  return Color.New(a.r + t * (b.r - a.r), a.g + t * (b.g - a.g), a.b + t * (b.b - a.b), a.a + t * (b.a - a.a))
end

function Color.LerpUnclamped(a, b, t)
  return Color.New(a.r + t * (b.r - a.r), a.g + t * (b.g - a.g), a.b + t * (b.b - a.b), a.a + t * (b.a - a.a))
end

function Color.HSVToRGB(H, S, V, hdr)
  if hdr then
  end
  hdr = true
  local white = Color.New(1, 1, 1, 1)
  if 0 == S then
    white.r = V
    white.g = V
    white.b = V
    return white
  end
  if 0 == V then
    white.r = 0
    white.g = 0
    white.b = 0
    return white
  end
  white.r = 0
  white.g = 0
  white.b = 0
  local num = S
  local num2 = V
  local f = H * 6
  local num4 = _floor(f)
  local num5 = f - num4
  local num6 = num2 * (1 - num)
  local num7 = num2 * (1 - num * num5)
  local num8 = num2 * (1 - num * (1 - num5))
  local num9 = num4
  local flag = num9 + 1
  if 0 == flag then
    white.r = num2
    white.g = num6
    white.b = num7
  elseif 1 == flag then
    white.r = num2
    white.g = num8
    white.b = num6
  elseif 2 == flag then
    white.r = num7
    white.g = num2
    white.b = num6
  elseif 3 == flag then
    white.r = num6
    white.g = num2
    white.b = num8
  elseif 4 == flag then
    white.r = num6
    white.g = num7
    white.b = num2
  elseif 5 == flag then
    white.r = num8
    white.g = num6
    white.b = num2
  elseif 6 == flag then
    white.r = num2
    white.g = num6
    white.b = num7
  elseif 7 == flag then
    white.r = num2
    white.g = num8
    white.b = num6
  end
  if not hdr then
    white.r = Math.Clamp(white.r, 0, 1)
    white.g = Math.Clamp(white.g, 0, 1)
    white.b = Math.Clamp(white.b, 0, 1)
  end
  return white
end

local function RGBToHSVHelper(offset, dominantcolor, colorone, colortwo)
  local V = dominantcolor
  if 0 ~= V then
    local num = 0
    if colortwo < colorone then
      num = colortwo
    else
      num = colorone
    end
    local num2 = V - num
    local H = 0
    local S = 0
    if 0 ~= num2 then
      S = num2 / V
      H = offset + (colorone - colortwo) / num2
    else
      S = 0
      H = offset + (colorone - colortwo)
    end
    H = H / 6
    if H < 0 then
      H = H + 1
    end
    return H, S, V
  end
  return 0, 0, V
end

function Color.RGBToHSV(rgbColor)
  if rgbColor.b > rgbColor.g and rgbColor.b > rgbColor.r then
    return RGBToHSVHelper(4, rgbColor.b, rgbColor.r, rgbColor.g)
  elseif rgbColor.g > rgbColor.r then
    return RGBToHSVHelper(2, rgbColor.g, rgbColor.b, rgbColor.r)
  else
    return RGBToHSVHelper(0, rgbColor.r, rgbColor.g, rgbColor.b)
  end
end

function Color.GrayScale(a)
  return 0.299 * a.r + 0.587 * a.g + 0.114 * a.b
end

function Color:__tostring()
  return string.format("RGBA(%f,%f,%f,%f)", self.r, self.g, self.b, self.a)
end

function Color.__add(a, b)
  return Color.New(a.r + b.r, a.g + b.g, a.b + b.b, a.a + b.a)
end

function Color.__sub(a, b)
  return Color.New(a.r - b.r, a.g - b.g, a.b - b.b, a.a - b.a)
end

function Color.__mul(a, b)
  if "number" == type(b) then
    return Color.New(a.r * b, a.g * b, a.b * b, a.a * b)
  elseif getmetatable(b) == Color then
    return Color.New(a.r * b.r, a.g * b.g, a.b * b.b, a.a * b.a)
  end
end

function Color.__div(a, d)
  return Color.New(a.r / d, a.g / d, a.b / d, a.a / d)
end

function Color.__eq(a, b)
  return a.r == b.r and a.g == b.g and a.b == b.b and a.a == b.a
end

Color.red = (function()
  return Color.New(1, 0, 0, 1)
end)()
Color.green = (function()
  return Color.New(0, 1, 0, 1)
end)()
Color.blue = (function()
  return Color.New(0, 0, 1, 1)
end)()
Color.white = (function()
  return Color.New(1, 1, 1, 1)
end)()
Color.black = (function()
  return Color.New(0, 0, 0, 1)
end)()
Color.yellow = (function()
  return Color.New(1, 0.9215686, 0.01568628, 1)
end)()
Color.cyan = (function()
  return Color.New(0, 1, 1, 1)
end)()
Color.magenta = (function()
  return Color.New(1, 0, 1, 1)
end)()
Color.gray = (function()
  return Color.New(0.5, 0.5, 0.5, 1)
end)()
Color.clear = (function()
  return Color.New(0, 0, 0, 0)
end)()

function Color.gamma(c)
  return Color.New(Mathf.LinearToGammaSpace(c.r), Mathf.LinearToGammaSpace(c.g), Mathf.LinearToGammaSpace(c.b), c.a)
end

function Color.linear(c)
  return Color.New(Mathf.GammaToLinearSpace(c.r), Mathf.GammaToLinearSpace(c.g), Mathf.GammaToLinearSpace(c.b), c.a)
end

function Color.maxColorComponent(c)
  return Mathf.Max(Mathf.Max(c.r, c.g), c.b)
end

Color.grayscale = Color.GrayScale

function Color.set_color(graphic, color)
  graphic:SetGraphicColor(color.r, color.g, color.b, color.a)
end

return Color
