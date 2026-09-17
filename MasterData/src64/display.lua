local var_0_0 = {}
local var_0_1 = cc.Director:getInstance()
local var_0_2 = cc.Director:getInstance():getTextureCache()
local var_0_3 = cc.SpriteFrameCache:getInstance()
local var_0_4 = cc.AnimationCache:getInstance()
local var_0_5 = var_0_1:getOpenGLView()

if var_0_5 == nil then
	var_0_5 = cc.GLView:createWithRect("hcollege", cc.rect(0, 0, config._SCREEN_WIDTH, config._SCREEN_HEIGHT), config._FRAME_ZOOM)

	var_0_1:setOpenGLView(var_0_5)
end

local var_0_6 = var_0_5:getFrameSize()
local var_0_7 = var_0_6.height / var_0_6.width

var_0_0.sizeInPixels = {
	width = var_0_6.width,
	height = var_0_6.height
}

local var_0_8 = config._DESIGN_HEIGHT
local var_0_9

var_0_0.autoscale = ""

if var_0_0.sizeInPixels.width / config._DESIGN_WIDTH <= var_0_0.sizeInPixels.height / config._DESIGN_HEIGHT then
	var_0_9 = var_0_0.sizeInPixels.width / config._DESIGN_WIDTH
	var_0_8 = var_0_0.sizeInPixels.height / (var_0_0.sizeInPixels.width / config._DESIGN_WIDTH)
	var_0_0.autoscale = "FIXED_HEIGHT"

	var_0_5:setDesignResolutionSize(config._DESIGN_WIDTH, var_0_8, cc.ResolutionPolicy.NO_BORDER)
else
	var_0_9 = var_0_0.sizeInPixels.height / config._DESIGN_HEIGHT
	var_0_0.autoscale = "FIXED_WIDTH"

	var_0_5:setDesignResolutionSize(config._DESIGN_WIDTH, var_0_8, cc.ResolutionPolicy.SHOW_ALL)
end

var_0_1:setDisplayStats(config.show_display_stats)

local var_0_10 = 0

if cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_WINDOWS and cc.Native:hasNotchInScreen() then
	var_0_10 = cc.Native:getStatusBarHeight() / var_0_9
end

if var_0_0.autoscale == "FIXED_WIDTH" then
	var_0_10 = 0
end

local var_0_11 = var_0_1:getWinSize()

var_0_0.screenScale = 2
var_0_0.contentScaleFactor = var_0_9
var_0_0.size = {
	width = var_0_11.width,
	height = var_0_11.height
}
var_0_0.width = var_0_0.size.width
var_0_0.height = var_0_0.size.height - var_0_10
var_0_0.cx = var_0_0.width / 2
var_0_0.cy = var_0_0.height / 2
var_0_0.c_left = -var_0_0.width / 2
var_0_0.c_right = var_0_0.width / 2
var_0_0.c_top = var_0_0.height / 2
var_0_0.c_bottom = -var_0_0.height / 2
var_0_0.left = 0
var_0_0.right = var_0_0.width
var_0_0.top = var_0_0.height
var_0_0.bottom = 0
var_0_0.widthInPixels = var_0_0.sizeInPixels.width
var_0_0.heightInPixels = var_0_0.sizeInPixels.height
var_0_0.ratio = var_0_7
var_0_0.fix_x = var_0_0.cx - config._DESIGN_WIDTH / 2
var_0_0.fix_y = var_0_0.cy - config._DESIGN_HEIGHT / 2
var_0_0.origin_design_x = config._DESIGN_WIDTH
var_0_0.origin_design_y = config._DESIGN_HEIGHT
var_0_0.notch_height = 0
var_0_0.statusbar_height = var_0_10

print(string.format("# display.autoscale            = %s", var_0_0.autoscale))
print(string.format("# display.widthInPixels        = %0.2f", var_0_0.widthInPixels))
print(string.format("# display.heightInPixels       = %0.2f", var_0_0.heightInPixels))
print(string.format("# display.ratio                = %0.2f", var_0_0.ratio))
print(string.format("# display.contentScaleFactor   = %0.2f", var_0_0.contentScaleFactor))
print(string.format("# display.width                = %0.2f", var_0_0.width))
print(string.format("# display.height               = %0.2f", var_0_0.height))
print(string.format("# display.cx                   = %0.2f", var_0_0.cx))
print(string.format("# display.cy                   = %0.2f", var_0_0.cy))
print(string.format("# display.left                 = %0.2f", var_0_0.left))
print(string.format("# display.right                = %0.2f", var_0_0.right))
print(string.format("# display.top                  = %0.2f", var_0_0.top))
print(string.format("# display.bottom               = %0.2f", var_0_0.bottom))
print(string.format("# display.c_left               = %0.2f", var_0_0.c_left))
print(string.format("# display.c_right              = %0.2f", var_0_0.c_right))
print(string.format("# display.c_top                = %0.2f", var_0_0.c_top))
print(string.format("# display.c_bottom             = %0.2f", var_0_0.c_bottom))
print(string.format("# display.fix_x                = %0.2f", var_0_0.fix_x))
print(string.format("# display.fix_y                = %0.2f", var_0_0.fix_y))
print(string.format("# display.design_x             = %0.2f", var_0_0.origin_design_x))
print(string.format("# display.design_y             = %0.2f", var_0_0.origin_design_y))
print(string.format("# display.notch_height         = %0.2f", var_0_0.notch_height))
print(string.format("# display.statusbar_height     = %0.2f", var_0_0.statusbar_height))
print("#")

var_0_0.AUTO_SIZE = 0
var_0_0.FIXED_SIZE = 1
var_0_0.LEFT_TO_RIGHT = 0
var_0_0.RIGHT_TO_LEFT = 1
var_0_0.TOP_TO_BOTTOM = 2
var_0_0.BOTTOM_TO_TOP = 3
var_0_0.CENTER = 1
var_0_0.LEFT_TOP = 2
var_0_0.TOP_LEFT = 2
var_0_0.CENTER_TOP = 3
var_0_0.TOP_CENTER = 3
var_0_0.RIGHT_TOP = 4
var_0_0.TOP_RIGHT = 4
var_0_0.CENTER_LEFT = 5
var_0_0.LEFT_CENTER = 5
var_0_0.CENTER_RIGHT = 6
var_0_0.RIGHT_CENTER = 6
var_0_0.BOTTOM_LEFT = 7
var_0_0.LEFT_BOTTOM = 7
var_0_0.BOTTOM_RIGHT = 8
var_0_0.RIGHT_BOTTOM = 8
var_0_0.BOTTOM_CENTER = 9
var_0_0.CENTER_BOTTOM = 9
var_0_0.ANCHOR_POINTS = {
	cc.p(0.5, 0.5),
	cc.p(0, 1),
	cc.p(0.5, 1),
	cc.p(1, 1),
	cc.p(0, 0.5),
	cc.p(1, 0.5),
	cc.p(0, 0),
	cc.p(1, 0),
	cc.p(0.5, 0)
}

function var_0_0.isDeviceFullScreen()
	return var_0_0.ratio > 2
end

function var_0_0.hasNotchInScreen()
	return var_0_0.statusbar_height > 0
end

function var_0_0.pos_transform(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0 == TRANSFORM_REFERENCE.UP then
		if arg_3_2 == TRANSFORM_UNIT.PX then
			return var_0_0.top - var_0_0.fix_y - var_0_0.notch_height - arg_3_1
		elseif arg_3_2 == TRANSFORM_UNIT.PER then
			return var_0_0.top - var_0_0.fix_y - var_0_0.notch_height - arg_3_1 * var_0_0.height
		end
	elseif arg_3_0 == TRANSFORM_REFERENCE.DOWN then
		if arg_3_2 == TRANSFORM_UNIT.PX then
			return -var_0_0.fix_y + arg_3_1
		elseif arg_3_2 == TRANSFORM_UNIT.PER then
			return -var_0_0.fix_y + arg_3_1 * var_0_0.height
		end
	end
end

function var_0_0.getRelativeScale()
	return (var_0_0.height - var_0_0.notch_height) / config._DESIGN_HEIGHT
end

function var_0_0.getScreenSize()
	return cc.size(var_0_0.width, var_0_0.height)
end

function var_0_0.getUiScreenSize()
	return cc.size(var_0_0.width, var_0_0.height - var_0_0.notch_height)
end

return var_0_0
