-- chunkname: @modules/logic/gm/model/GMPostProcessModel.lua

module("modules.logic.gm.model.GMPostProcessModel", package.seeall)

local GMPostProcessModel = class("GMPostProcessModel", MixScrollModel)

GMPostProcessModel.Interfaces = {
	{
		{
			val = "LocalBloomActive",
			name = "局部bloom开关",
			type = "bool"
		},
		{
			val = "LocalBloomColor",
			name = "局部bloom颜色",
			type = "Color"
		},
		{
			name = "全局bloom强度",
			min = 0,
			type = "float",
			val = "BloomIntensity",
			max = 40
		},
		{
			name = "全局bloom颜色阈值",
			min = 0,
			type = "float",
			val = "BloomThreshold",
			max = 4
		},
		{
			name = "<size=26>全局bloom颜色大小\n越大越耗</size>",
			min = 0,
			type = "float",
			val = "BloomDiffusion",
			max = 10
		},
		{
			name = "bloom rt 缩放幂次 1 高 2中 3低",
			min = 0,
			type = "int",
			val = "BloomRTDownTimes",
			max = 3
		}
	},
	{
		{
			name = "旋涡角度",
			min = 0,
			type = "float",
			val = "VortexAngle",
			max = 720
		},
		{
			name = "旋涡幅度",
			min = 0,
			type = "float",
			val = "VortexRange",
			max = 100
		},
		{
			val = "VortexCenter",
			name = "旋涡中心",
			type = "Vector2"
		}
	},
	{
		{
			name = "局部Mask rt 缩放幂次数",
			min = 0,
			type = "int",
			val = "PostLocalMaskTexDownTimes",
			max = 3
		},
		{
			name = "局部Mask rt 缩放幂次数",
			min = 0,
			type = "int",
			val = "PreLocalMaskTexDownTimes",
			max = 3
		},
		{
			name = "局部扭曲效果强度",
			min = 0,
			type = "float",
			val = "LocalDistortStrength",
			max = 1
		}
	},
	{
		{
			name = "颜色调整饱和度",
			min = 0,
			type = "float",
			val = "Saturation",
			max = 1
		},
		{
			name = "颜色调整对比度",
			min = 0,
			type = "float",
			val = "Contrast",
			max = 1
		},
		{
			val = "MulColor",
			name = "颜色调整颜色叠加",
			type = "Color"
		},
		{
			val = "KeepColor",
			name = "保留的颜色",
			type = "Color"
		},
		{
			name = "颜色保留强度",
			min = 0,
			type = "int",
			val = "KeepPow",
			max = 500
		},
		{
			val = "Inverse",
			name = "颜色反相",
			type = "bool"
		}
	},
	{
		{
			name = "高斯模糊强度",
			min = 0,
			type = "float",
			val = "GaussianBlurFactor",
			max = 6
		},
		{
			val = "GaussianBlurIsGlobal",
			name = "模糊是否全局",
			type = "bool"
		},
		{
			val = "GaussianBlurFreeze",
			name = "模糊定帧",
			type = "bool"
		}
	},
	{
		{
			val = "RgbSplitCenter",
			name = "<size=26>rgb分离、径向模糊中心\n两个效果共用</size>",
			type = "Vector2"
		},
		{
			name = "rgb分离强度",
			min = 0,
			type = "float",
			val = "RgbSplitStrength",
			max = 0.2
		}
	},
	{
		{
			name = "径向模糊采样次数",
			min = 1,
			type = "int",
			val = "RadialBlurLevel",
			max = 16
		},
		{
			name = "<size=26>rgb分离->径向模糊\n混合因子</size>",
			min = 0,
			type = "float",
			val = "RadialBlurLerp",
			max = 1
		}
	},
	{
		{
			val = "CharacterInvisibleActive",
			name = "隐身",
			type = "bool"
		}
	}
}

function GMPostProcessModel:onInit()
	self:addList(GMPostProcessModel.Interfaces)

	self.ppType = 2
end

function GMPostProcessModel:getInfoList(scrollGO)
	local mixCellInfos = {}

	for i, one in ipairs(GMPostProcessModel.Interfaces) do
		local oneCount = #one
		local lineHeight = 65 * oneCount + 50
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(i, lineHeight, lineHeight)

		table.insert(mixCellInfos, mixCellInfo)
	end

	return mixCellInfos
end

GMPostProcessModel.instance = GMPostProcessModel.New()

return GMPostProcessModel
