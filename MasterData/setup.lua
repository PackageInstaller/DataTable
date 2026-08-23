DEBUG = 2
CC_USE_FRAMEWORK = true
CC_SHOW_FPS = true
CC_DISABLE_GLOBAL = true
GUIDE_CLOSE = false
BATTLE_SKIP_OPEN = false
GUIDE_IGNORE_ERROR = true
LAUNCH_MODULE_DIRECTLY = "HOME"
FONT_NAME = "Source Han Sans CN"
FONT_PATH = "font/SourceHanSansCN-Regular.otf"
FONT_TITLE_NAME = "Source Han Serif CN"
FONT_TITLE_PATH = "font/SourceHanSerifCN-Heavy-4.otf"
FONT_NUMBER_NAME = "Novecento wide"
FONT_NUMBER_PATH = "font/NOVECENTOWIDE-BOLD.OTF"
CC_DESIGN_RESOLUTION = {
	autoscale = "FIXED_WIDTH",
	height = 750,
	width = 1334,
	callback = function(self)
		if self.width / self.height > 1.6 then
			return {
				autoscale = "FIXED_HEIGHT"
			}
		else
			return {
				autoscale = "FIXED_WIDTH"
			}
		end
	end
}
