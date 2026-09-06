-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/Avatar.lua

module("logiccommon.common.avatar.Avatar", package.seeall)

local Avatar = class("Avatar", AvatarEffects)
local mainTexId = MaterialUtils.GetPropertyId("_MainTex")
local highlightColId = MaterialUtils.GetPropertyId("_HighlightCol")
local shadowColId = MaterialUtils.GetPropertyId("_ShadowCol")
local rampThresholdId = MaterialUtils.GetPropertyId("_RampThreshold")
local rampSmoothId = MaterialUtils.GetPropertyId("_RampSmooth")
local rimColorId = MaterialUtils.GetPropertyId("_RimColor")
local rimThresholdId = MaterialUtils.GetPropertyId("_RimThreshold")
local rimSmoothId = MaterialUtils.GetPropertyId("_RimSmooth")
local outlineWidthId = MaterialUtils.GetPropertyId("_OutlineWidth")
local outlineColorId = MaterialUtils.GetPropertyId("_OutlineColor")

Avatar.OnSkeletonLoaded = 1
Avatar.OnPartLoaded = 2
Avatar.OnMountLoaded = 3
Avatar.OnAvatarLoaded = 4
Avatar.AvatarModel = {
	Low = 2,
	Hpm = 1
}
Avatar.DebugParam = false

function Avatar:ctor()
	NotifyDispatcher.extend(self)
	Avatar.super.ctor(self)

	self.avatarType = AvatarType.UI
	self.avatarModelType = Avatar.AvatarModel.Hpm
	self._resLoader = AvatarResLoader.New(false, self._onSkeletonLoaded, self)
	self._lastCombition = nil
	self._lastSmrenderer = nil
	self._combition = nil
	self.parent = nil
	self.layer = nil
	self._syncMout = nil
	self._skeletonsMap = nil
	self.parts = {}
	self.mount = AvatarMount.New(self)
	self._mountModel = nil
	self.isMounted = nil
	self._animatorUpdateMode = nil
	self._animatorCullingMode = nil
	self._mountSycBone = nil
	self._bonesRef = nil

	self.addListener(self, Avatar.OnPartLoaded, self._onSkinedMeshLoaded, self)
	self.addListener(self, Avatar.OnMountLoaded, self._onMountLoaded, self)
	self.mount:setPreRecycleHandler(self._onRecycleMountResObject, self)
	self:_initAvatarMatInfo()
end

function Avatar:_initAvatarMatInfo()
	self._matResourcesList = nil
	self._matRes = nil
	self._farCamera = nil
	self._updateMatForUI = false
	self._removeRim = false

	if Avatar.DebugParam then
		self._createRoleMat = {
			{
				{
					AvatarPartType.Top,
					"aoqinv_clothes",
					"avatars/skinedmeshes/top/70002_aoqinv_huanxiangtao_top_cr.mat",
					"character/70002_aoqinv_huanxiangtao/70002_aoqinv_huanxiangtao_top_cr2.mat"
				},
				{
					AvatarPartType.Face,
					"",
					"avatars/skinedmeshes/face/70002_aoqinv_huanxiangtao_face_cr.mat",
					"character/70002_aoqinv_huanxiangtao/70002_aoqinv_huanxiangtao_face_cr2.mat"
				},
				{
					AvatarPartType.Shoes,
					"aoqinv_shoes01",
					"avatars/skinedmeshes/shoes/70002_aoqinv_huanxiangtao_shoes_cr.mat",
					"character/70002_aoqinv_huanxiangtao/70002_aoqinv_huanxiangtao_shoes_cr2.mat"
				},
				{
					AvatarPartType.Arm,
					"aoqinv_body",
					"avatars/skinedmeshes/arm/70002_aoqinv_huanxiangtao_arm_cr.mat",
					"character/70002_aoqinv_huanxiangtao/70002_aoqinv_huanxiangtao_arm_cr2.mat"
				},
				{
					AvatarPartType.Hair,
					"aoqinv_hair01",
					"avatars/skinedmeshes/hair/70002_aoqinv_huanxiangtao_hair_cr.mat",
					"character/70002_aoqinv_huanxiangtao/70002_aoqinv_huanxiangtao_hair_cr2.mat"
				}
			},
			{
				{
					AvatarPartType.Top,
					"aoqinan_clothes",
					"avatars/skinedmeshes/top/99999_aoqinan_xiaoaoqi_top_cr.mat",
					"character/99999_xiaoaoqi_nan/99999_aoqinan_xiaoaoqi_top_cr2.mat"
				},
				{
					AvatarPartType.Face,
					"",
					"avatars/skinedmeshes/face/99999_aoqinan_xiaoaoqi_face_cr.mat",
					"character/99999_xiaoaoqi_nan/99999_aoqinan_xiaoaoqi_face_cr2.mat"
				},
				{
					AvatarPartType.Shoes,
					"aoqinan_shoes_01",
					"avatars/skinedmeshes/shoes/99999_aoqinan_xiaoaoqi_shoes_cr.mat",
					"character/99999_xiaoaoqi_nan/99999_aoqinan_xiaoaoqi_shoes_cr2.mat"
				},
				{
					AvatarPartType.Arm,
					"aoqinan_body",
					"avatars/skinedmeshes/arm/99999_aoqinan_xiaoaoqi_arm_cr.mat",
					"character/99999_xiaoaoqi_nan/99999_aoqinan_xiaoaoqi_arm_cr2.mat"
				},
				{
					AvatarPartType.Pants,
					"aoqinan_trousers_01",
					"avatars/skinedmeshes/pants/99999_aoqinan_xiaoaoqi_pants_cr.mat",
					"character/99999_xiaoaoqi_nan/99999_aoqinan_xiaoaoqi_pants_cr2.mat"
				},
				{
					AvatarPartType.Hair,
					"aoqinan_hear",
					"avatars/skinedmeshes/hair/99999_aoqinan_xiaoaoqi_hair_cr.mat",
					"character/99999_xiaoaoqi_nan/99999_aoqinan_xiaoaoqi_hair_cr2.mat"
				}
			}
		}
		self._showRoleMat = {
			{
				{
					AvatarPartType.Top,
					"aoqinv_clothes",
					"character/70002_aoqinv_huanxiangtao/70002_aoqinv_huanxiangtao_top_hpm_ui.mat"
				},
				{
					AvatarPartType.Face,
					"",
					"character/70002_aoqinv_huanxiangtao/70002_aoqinv_huanxiangtao_face_hpm_ui.mat"
				},
				{
					AvatarPartType.Shoes,
					"aoqinv_shoes01",
					"character/70002_aoqinv_huanxiangtao/70002_aoqinv_huanxiangtao_shoes_hpm_ui.mat"
				},
				{
					AvatarPartType.Arm,
					"aoqinv_body",
					"character/70002_aoqinv_huanxiangtao/70002_aoqinv_huanxiangtao_arm_hpm_ui.mat"
				},
				{
					AvatarPartType.Hair,
					"aoqinv_hair01",
					"character/70002_aoqinv_huanxiangtao/70002_aoqinv_huanxiangtao_hair_hpm_ui.mat"
				}
			},
			{
				{
					AvatarPartType.Top,
					"aoqinan_clothes",
					"character/99999_xiaoaoqi_nan/99999_aoqinan_xiaoaoqi_top_hpm_ui.mat"
				},
				{
					AvatarPartType.Face,
					"",
					"character/99999_xiaoaoqi_nan/99999_aoqinan_xiaoaoqi_face_hpm_ui.mat"
				},
				{
					AvatarPartType.Shoes,
					"aoqinan_shoes_01",
					"character/99999_xiaoaoqi_nan/99999_aoqinan_xiaoaoqi_shoes_hpm_ui.mat"
				},
				{
					AvatarPartType.Arm,
					"aoqinan_body",
					"character/99999_xiaoaoqi_nan/99999_aoqinan_xiaoaoqi_arm_hpm_ui.mat"
				},
				{
					AvatarPartType.Pants,
					"aoqinan_trousers_01",
					"character/99999_xiaoaoqi_nan/99999_aoqinan_xiaoaoqi_pants_hpm_ui.mat"
				},
				{
					AvatarPartType.Hair,
					"aoqinan_hear",
					"character/99999_xiaoaoqi_nan/99999_aoqinan_xiaoaoqi_hair_hpm_ui.mat"
				}
			}
		}
	else
		self._createRoleMat = {
			{
				{
					AvatarPartType.Top,
					"aoqinv_clothes",
					{
						0.5514706,
						0.5514706,
						0.5514706,
						1,
						1,
						0,
						0,
						0,
						1,
						0.0069,
						0.0124,
						0.5073529,
						0.390034,
						0.2835208,
						1,
						1.2,
						0.66,
						0.2378352,
						0.4407611,
						0.6102941,
						1,
						0.583,
						0.47,
						0.2352941,
						0.2171578,
						0.200692,
						1,
						3
					},
					{
						0.7568628,
						0.7450981,
						0.7411765,
						1,
						0.53,
						1,
						1,
						1,
						1,
						0.082,
						0,
						0.7137255,
						0.6392157,
						0.6117647,
						1,
						1.01,
						0.669,
						0.3615917,
						0.4698724,
						0.6470588,
						1,
						0.484,
						0.39,
						0.09558821,
						0.04683435,
						0.02038278,
						1,
						2
					}
				},
				{
					AvatarPartType.Face,
					"",
					{
						0.9558824,
						0.9066826,
						0.9066826,
						1,
						0.39,
						1,
						1,
						1,
						1,
						0.0069,
						0.0186,
						0.3882353,
						0.1921569,
						0.01568628,
						1,
						10,
						0.336,
						1,
						0,
						0,
						1,
						0.73,
						0.66,
						0.3602941,
						0.2422667,
						0.1351103,
						1,
						4
					},
					{
						0.9333333,
						0.8862745,
						0.8862745,
						1,
						0.347,
						0,
						0,
						0,
						1,
						0.0069,
						0.0128,
						0.3823529,
						0.3373702,
						0.3373702,
						1,
						4.35,
						0.172,
						0,
						0,
						0,
						1,
						0.8,
						0.8,
						0,
						0,
						0,
						1,
						2
					}
				},
				{
					AvatarPartType.Shoes,
					"aoqinv_shoes01",
					{
						0.8235294,
						0.8235294,
						0.8235294,
						1,
						1,
						1,
						1,
						1,
						1,
						0.0069,
						0.0124,
						0,
						0,
						0,
						1,
						1,
						0.653,
						1,
						0.8133874,
						0.4117647,
						1,
						0.8,
						0.8,
						0,
						0,
						0,
						1,
						4.4
					},
					{
						0.8235294,
						0.8235294,
						0.8235294,
						1,
						1,
						1,
						1,
						1,
						1,
						0.0069,
						0.0124,
						0,
						0,
						0,
						1,
						1,
						0.653,
						1,
						0.8133874,
						0.4117647,
						1,
						0.8,
						0.8,
						0,
						0,
						0,
						1,
						4.4
					}
				},
				{
					AvatarPartType.Arm,
					"aoqinv_body",
					{
						0.7279412,
						0.6369485,
						0.6369485,
						1,
						1,
						1,
						1,
						1,
						1,
						0.0038,
						0,
						0.5588235,
						0.4117647,
						0.2794118,
						1,
						0.7,
						0.61,
						1,
						0.7669588,
						0.217939,
						1,
						0.817,
						0.808,
						0.2279412,
						0.1454801,
						0.08212586,
						1,
						4
					},
					{
						0.9044118,
						0.8046605,
						0.8046605,
						1,
						1,
						0,
						0,
						0,
						1,
						0.0038,
						0.008,
						0,
						0,
						0,
						1,
						0.3,
						0.551,
						1,
						0.7669588,
						0.217939,
						1,
						0.817,
						0.808,
						0.4558824,
						0.290729,
						0.1407872,
						1,
						2
					}
				},
				{
					AvatarPartType.Hair,
					"aoqinv_hair01",
					{
						0.3308824,
						0.2758472,
						0.233564,
						1,
						0.762,
						1,
						0.9827586,
						0.75,
						1,
						0.011,
						0.0078,
						0.6911765,
						0.5251819,
						0.3150952,
						1,
						3.39,
						0.658,
						0.2536765,
						0.4490365,
						0.6764706,
						1,
						0.607,
						0.244,
						0.5137255,
						0.3333333,
						0.05882353,
						1,
						4
					},
					{
						0.3764706,
						0.3254902,
						0.282353,
						1,
						0.638,
						0.7132353,
						0.7132353,
						0.7132353,
						1,
						0,
						0,
						0.7568628,
						0.6941177,
						0.6509804,
						1,
						2.9,
						0.588,
						0,
						0,
						0,
						1,
						1,
						1,
						0.8156863,
						0.6588235,
						0.4196078,
						1,
						2
					}
				}
			},
			{
				{
					AvatarPartType.Top,
					"aoqinan_clothes",
					{
						0.6176471,
						0.6176471,
						0.6176471,
						1,
						1,
						0.5220588,
						0.2072881,
						0.2072881,
						1,
						0.025,
						0.01,
						0.2867647,
						0.2235078,
						0.1286224,
						1,
						1.26,
						0.6,
						0,
						0,
						0,
						1,
						0.658,
						0.644,
						0.3823529,
						0.07309689,
						0.07309689,
						1,
						3
					},
					{
						0.6176471,
						0.6176471,
						0.6176471,
						1,
						1,
						0,
						0,
						0,
						1,
						0.051,
						0.01,
						0.2058824,
						0.1424055,
						0.08477509,
						1,
						1.26,
						0.695,
						0.2540009,
						0.4960639,
						0.6397059,
						1,
						0.842,
						0.786,
						0,
						0,
						0,
						1,
						1.5
					}
				},
				{
					AvatarPartType.Face,
					"",
					{
						0.8529412,
						0.8048443,
						0.8027682,
						1,
						0.516,
						1,
						1,
						1,
						1,
						0.276,
						0.044,
						0.2720588,
						0.2112457,
						0.120026,
						1,
						5.67,
						0.25,
						0.2711938,
						0.4759755,
						0.6470588,
						1,
						0.567,
						0.197,
						0,
						0,
						0,
						1,
						5
					},
					{
						0.9490196,
						0.7686275,
						0.7686275,
						1,
						0.457,
						1,
						1,
						1,
						1,
						0.276,
						0.044,
						0.1176471,
						0.1176471,
						0.1176471,
						1,
						9.37,
						0.392,
						0.2372945,
						0.3664516,
						0.4191176,
						1,
						0.411,
						0.035,
						0,
						0,
						0,
						1,
						1.5
					}
				},
				[4] = {
					AvatarPartType.Arm,
					"aoqinan_body",
					{
						1,
						0.8529412,
						0.8529412,
						1,
						0.836,
						1,
						1,
						1,
						1,
						0.263,
						0.0509,
						0.2279412,
						0.1776369,
						0.1139706,
						1,
						0.36,
						0.37,
						0.2033953,
						0.4036407,
						0.4852941,
						1,
						0.352,
						0.391,
						0.1617647,
						0.1095111,
						0.05352508,
						1,
						4
					},
					{
						0.9411765,
						0.8581315,
						0.8581315,
						1,
						0.761,
						0.9485294,
						0.4393923,
						0.4393923,
						1,
						0.258,
						0.0514,
						0.6838235,
						0.4022491,
						0.4022491,
						1,
						0.54,
						0.429,
						0.625,
						0.625,
						0.625,
						1,
						0.794,
						0.474,
						0,
						0,
						0,
						1,
						1.5
					}
				},
				[5] = {
					AvatarPartType.Pants,
					"aoqinan_trousers_01",
					{
						0.3014706,
						0.3014706,
						0.3014706,
						1,
						1,
						0.5,
						0.5,
						0.5,
						1,
						0.241,
						0.044,
						0.5588235,
						0.2999567,
						0.2999567,
						1,
						5.09,
						0.604,
						0.221237,
						0.3978822,
						0.4852941,
						1,
						0.72,
						0.15,
						0,
						0,
						0,
						1,
						4
					},
					{
						0.3014706,
						0.3014706,
						0.3014706,
						1,
						1,
						1,
						1,
						1,
						1,
						0.241,
						0.044,
						0.1470588,
						0.0988844,
						0.05514707,
						1,
						2.6,
						0.546,
						0.2283737,
						0.3896134,
						0.4852941,
						1,
						0.413,
						0.37,
						0,
						0,
						0,
						1,
						1.5
					}
				},
				[6] = {
					AvatarPartType.Hair,
					"aoqinan_hear",
					{
						0.4411765,
						0.4411765,
						0.4411765,
						1,
						1,
						0.9779412,
						0.9237874,
						0.6975021,
						1,
						0.017,
						0.0072,
						0.4926471,
						0.329364,
						0.1811202,
						1,
						2.2,
						0.4,
						0.2072881,
						0.3527339,
						0.5220588,
						1,
						1,
						1,
						0,
						0,
						0,
						1,
						3
					},
					{
						0.3602941,
						0.3443988,
						0.3443988,
						1,
						1,
						0.6985294,
						0.5708671,
						0.5238971,
						1,
						0.017,
						0,
						0.5294118,
						0.3939447,
						0.190744,
						1,
						2.59,
						0.421,
						0.2205882,
						0.3843814,
						0.5,
						1,
						0.673,
						0.173,
						0,
						0,
						0,
						1,
						2
					}
				}
			}
		}
		self._showRoleMat = {
			{
				{
					AvatarPartType.Top,
					"aoqinv_clothes",
					{
						0.6764706,
						0.6571233,
						0.6466263,
						1,
						0.679,
						0.5367647,
						0.5367647,
						0.5367647,
						1,
						0,
						0,
						0.5,
						0.3918864,
						0.3088235,
						1,
						0.88,
						0.575,
						0.3615917,
						0.4698724,
						0.6470588,
						1,
						0.492,
						0.213,
						0.3676471,
						0.3070561,
						0.3000649,
						1,
						3
					}
				},
				{
					AvatarPartType.Face,
					"",
					{
						0.8235294,
						0.7932526,
						0.7932526,
						1,
						0.259,
						0,
						0,
						0,
						1,
						0.0069,
						0.0113,
						0.6397059,
						0.4609645,
						0.4609645,
						1,
						3.35,
						0.393,
						0,
						0,
						0,
						1,
						0.8,
						0.8,
						0.6838235,
						0.5359623,
						0.4223616,
						1,
						3
					}
				},
				{
					AvatarPartType.Shoes,
					"aoqinv_shoes01",
					{
						0.1911765,
						0.1911765,
						0.1911765,
						1,
						0.462,
						1,
						1,
						1,
						1,
						0.022,
						0.0124,
						0.6617647,
						0.6082397,
						0.6082397,
						1,
						5.05,
						0.567,
						1,
						0.8133874,
						0.4117647,
						1,
						0.8,
						0.8,
						0.4117647,
						0.4117647,
						0.4117647,
						1,
						4
					}
				},
				{
					AvatarPartType.Arm,
					"aoqinv_body",
					{
						0.9264706,
						0.7289144,
						0.7289144,
						1,
						0.99,
						0,
						0,
						0,
						1,
						0.0038,
						0.008,
						0.3161765,
						0.2744899,
						0.1999351,
						1,
						0.35,
						0.546,
						1,
						0.7669588,
						0.217939,
						1,
						0.583,
						0.808,
						0.5294118,
						0.3621047,
						0.2102076,
						1,
						3
					}
				},
				{
					AvatarPartType.Hair,
					"aoqinv_hair01",
					{
						0.4338235,
						0.3836654,
						0.3381272,
						1,
						0.407,
						0.7867647,
						0.7127163,
						0.6016436,
						1,
						0,
						0,
						0.6911765,
						0.5585491,
						0.4726427,
						1,
						1.92,
						0.528,
						0.5147059,
						0.2307303,
						0.2119377,
						1,
						0.632,
						0.072,
						0.25,
						0.1580882,
						0.02022059,
						1,
						2
					}
				}
			},
			{
				{
					AvatarPartType.Top,
					"aoqinan_clothes",
					{
						0.6176471,
						0.6176471,
						0.6176471,
						1,
						0.491,
						0,
						0,
						0,
						1,
						0.141,
						0.0633,
						0.5220588,
						0.5220588,
						0.5220588,
						1,
						1.26,
						0.631,
						0.2540009,
						0.4960639,
						0.6397059,
						1,
						0.682,
						0.786,
						0,
						0,
						0,
						1,
						1.5
					}
				},
				{
					AvatarPartType.Face,
					"",
					{
						0.9568627,
						0.8352941,
						0.8745098,
						1,
						0.259,
						0,
						0,
						0,
						1,
						0.276,
						0.044,
						0.2279412,
						0.2198499,
						0.2162089,
						1,
						6.86,
						0.412,
						0.2372945,
						0.3664516,
						0.4191176,
						1,
						0.411,
						0.035,
						0,
						0,
						0,
						1,
						1.5
					}
				},
				[4] = {
					AvatarPartType.Arm,
					"aoqinan_body",
					{
						0.9411765,
						0.8039216,
						0.8039216,
						1,
						0.42,
						1,
						1,
						1,
						1,
						0.258,
						0,
						0.6617647,
						0.6617647,
						0.6617647,
						1,
						0.84,
						0.448,
						0.625,
						0.625,
						0.625,
						1,
						0.794,
						0.474,
						0,
						0,
						0,
						1,
						1.5
					}
				},
				[5] = {
					AvatarPartType.Pants,
					"aoqinan_trousers_01",
					{
						0.3014706,
						0.3014706,
						0.3014706,
						1,
						0.491,
						0.4117647,
						0.3724048,
						0.3724048,
						1,
						0.032,
						0.0024,
						0.4264706,
						0.3541522,
						0.2884948,
						1,
						2.6,
						0.551,
						0.2283737,
						0.3896134,
						0.4852941,
						1,
						0.762,
						0,
						0,
						0,
						0,
						1,
						1.5
					}
				},
				[6] = {
					AvatarPartType.Hair,
					"aoqinan_hear",
					{
						0.3602941,
						0.3443988,
						0.3443988,
						1,
						0.484,
						0.6985294,
						0.5708671,
						0.5238971,
						1,
						0.017,
						0.0065,
						0.5294118,
						0.3939447,
						0.190744,
						1,
						2.24,
						0.584,
						0.2205882,
						0.3843814,
						0.5,
						1,
						0.534,
						0.173,
						0,
						0,
						0,
						1,
						2
					}
				}
			}
		}
	end
end

function Avatar:setParent(parent)
	self.parent = parent

	self._resLoader:setParent(parent)
end

function Avatar:setLayer(layer)
	self.layer = layer

	for k, v in pairs(self.parts) do
		v:setLayer(layer)
	end

	local resObject = self._resLoader:getResObject()

	if resObject then
		resObject:setLayer(layer)
	end

	self.mount:setLayer(layer)
end

function Avatar:rebindAnimator()
	local animator = self:getAnimator()

	if animator then
		animator:Rebind()
		self:updateMountingLayer()
		self:onIdle()
	end
end

function Avatar:loadSkelegon(skeletonPath)
	if self._resLoader:getResPath() == skeletonPath then
		if self:isSkelegonLoaded() then
			self.dispatch(self, Avatar.OnSkeletonLoaded, self)
		end

		return
	end

	self:clearEffects()
	self:dismount()
	self:detachAllParts()
	self:_clearLastCombition()

	self._lastCombition = self._combition
	self._lastSmrenderer = self._smrender
	self._skeletonsMap = nil
	self._syncMout = nil
	self._combition = nil
	self._smrender = nil
	self._animatorUpdateMode = nil
	self._animatorCullingMode = nil
	self._mountSycBone = nil
	self._bonesRef = nil
	self.mountLayerIndex = nil

	self:clearAnim()
	self._resLoader:load(skeletonPath)
end

function Avatar:load(avatarMo)
	if self.avatarMo and self.avatarMo:equal(avatarMo) then
		self.avatarMo.isMount = avatarMo.isMount

		self:_updateMountState()

		return
	end

	if self.isMounted and self.avatarMo and self.avatarMo.mount ~= avatarMo.mount and avatarMo.isMount then
		self.isMounted = nil
	end

	self.avatarMo = avatarMo

	self:updateByAvatarMo()
end

function Avatar:updateByAvatarMo()
	local skelCo = AvatarConfig.instance:getSkelCo(self.avatarMo.skeleton)

	self.gender = self.avatarMo.gender or skelCo.gender

	self:loadSkelegon(GameUrl.getAvatarSkel(self.avatarType, skelCo.asset))

	for k, v in pairs(AvatarPartType) do
		local id = self.avatarMo[AvatarPartTypeName[v]]

		if id and id > 0 then
			local skinCo = AvatarConfig.instance:getSkinMeshCo(self.avatarMo[AvatarPartTypeName[v]])

			self:addPart(v, GameUrl.getSkinMesh(self.avatarType, AvatarPartTypeName[v], skinCo.asset))
		else
			self:detachPart(v)
		end
	end

	self:_updateMountState()
	self:onIdle()
end

function Avatar:_updateMountState()
	local mountCo = self:_getMountCo()
	local mountModel, mountLayer

	if mountCo then
		mountModel = GameUrl.getMountUrl(self.avatarType, mountCo.mountMod)
		mountLayer = string.nilorempty(mountCo.mountLayer) and AnimatorHash.mountLayer or mountCo.mountLayer
	end

	self:setMount(mountModel, mountLayer)

	if self.avatarMo.isMount and not string.nilorempty(self._mountModel) then
		self:startMount()
	else
		self:dismount()
	end
end

function Avatar:_getMountCo()
	local mountCo

	if DressModel.EscortMountId == self.avatarMo.mount then
		mountCo = MountConfig.instance:getEscortMountCo()
	elseif self.avatarMo.mount and self.avatarMo.mount ~= 0 then
		mountCo = MountConfig.instance:getMountCo(self.avatarMo.mount)
	end

	return mountCo
end

function Avatar:addPart(partType, assetPath)
	if self:exist(partType, assetPath) then
		return
	end

	local part = self:getPart(partType)

	if not part then
		part = AvatarPart.New(partType, self)
		self.parts[partType] = part
	end

	part:load(assetPath)
end

function Avatar:detachPart(partType)
	if self.parts[partType] then
		self.parts[partType]:detach()
	end
end

function Avatar:detachAllParts()
	if self.parts then
		for k, v in pairs(self.parts) do
			v:detach()
		end
	end
end

function Avatar:destroyPart(partType)
	if self.parts[partType] then
		self.parts[partType]:destroy()

		self.parts[partType] = nil
	end
end

function Avatar:destroyAllParts()
	if self.parts then
		for k, v in pairs(self.parts) do
			v:destroy()
		end
	end
end

function Avatar:getPart(partType)
	return self.parts[partType]
end

function Avatar:exist(partType, assetPath)
	local part = self:getPart(partType)

	if not part then
		return
	end

	return part.assetPath == assetPath
end

function Avatar:isPartsLoaded()
	if self.parts then
		for k, v in pairs(self.parts) do
			if not v:isPartLoaded() then
				return
			end
		end
	end

	return true
end

function Avatar:onAvatarVisible(avatarMo)
	self:load(avatarMo)
end

function Avatar:onAvatarInvisible()
	if self._syncMout then
		self._syncMout.enabled = false
		self._syncMout = nil
	end

	self:clearEffects()
	self:detachAllParts()
	self:dismount()
	self:clearAnim()
	self._resLoader:clear()
	self:_clearCombition()
	self:_clearLastCombition()

	self.avatarMo = nil
end

function Avatar:reset()
	self:_clear()

	self.parent = nil
	self.layer = nil
end

function Avatar:_clear()
	if self._syncMout then
		self._syncMout.enabled = false
	end

	if self._activeListener then
		self._activeListener:RemoveListener()

		self._activeListener = nil
	end

	self:removeAllListener(Avatar.OnAvatarLoaded)
	self:clearEffects()

	self._syncMout = nil

	self:detachAllParts()
	self:dismount()
	self:clearAnim()
	self._resLoader:clear()
	self:_clearCombition()
	self:_clearLastCombition()

	self.avatarMo = nil
	self._animatorUpdateMode = nil
	self._animatorCullingMode = nil
	self._mountSycBone = nil
	self._bonesRef = nil
	self.isMounted = nil
	self._mountModel = nil
	self.mountLayerIndex = nil
	self._skeletonsMap = nil
	self._animLayers = nil
end

function Avatar:destroy()
	self:reset()
	self.mount:destroy()
	self:destroyAllParts()
	self:_clearCreateRoleMatRes()
end

function Avatar:isSkelegonLoaded()
	if string.nilorempty(self._resLoader:getResPath()) then
		return false
	end

	return self._resLoader:isLoaded()
end

function Avatar:getSkeletonObject()
	return self._resLoader:getResObject()
end

function Avatar:setSkeletonVisible(visible)
	local resObj = self:getSkeletonObject()

	if resObj then
		resObj:setActive(visible)

		if visible then
			self:updateMountingLayer()
		end
	end
end

function Avatar:onSetActive(active)
	if active then
		self:updateMountingLayer()
		self:onIdle()
	end
end

function Avatar:getGameObject()
	return self._resLoader:getGameObject()
end

function Avatar:getSkelMap()
	return self._skeletonsMap
end

function Avatar:getSkinedMeshRenderer()
	return self._smrender
end

function Avatar:sharedSkeletons()
	for k, v in pairs(self.parts) do
		v:sharedSkeletons(self._skeletonsMap)
	end
end

function Avatar:setCombition(combition)
	self:_buildSkinMeshRenderer()

	self._combition = combition
	self._smrender.sharedMesh = combition.combineMesh
	self._smrender.bones = combition.bones
	self._smrender.sharedMesh.uv = combition.uv

	local material = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/character/toon"))

	self._smrender.material = material

	material:SetTexture("_MainTex", combition.skinnedMeshAtlas.atlas)
	GoUtil.SetMatColor(material, "_HighlightCol", 1, 0.984313725490196, 0.9490196078431372, 1)
	GoUtil.SetMatColor(material, "_ShadowCol", 0.6980392156862745, 0.6470588235294118, 0.7058823529411765, 1)
	material:SetFloat("_RampThreshold", 0.2)
	material:SetFloat("_RampSmooth", 0.4)
	GoUtil.SetMatColor(material, "_RimColor", 0.30196078431372547, 0.4470588235294118, 0.4235294117647059, 1)
	material:SetFloat("_RimThreshold", 0.532)
	material:SetFloat("_RimSmooth", 0.42)
	material:SetFloat("_OutlineWidth", 0.006)
	GoUtil.SetMatColor(material, "_OutlineColor", 0.1607843137254902, 0.1607843137254902, 0.1607843137254902, 1)
	self:detachAllParts()
end

function Avatar:_setupCombitionMaterial(mainTexture)
	MaterialUtils.SetTexture(self._smrender, mainTexId, mainTexture)
	MaterialUtils.SetColorRGBA(self._smrender, highlightColId, 1, 0.984313725490196, 0.9490196078431372, 1)
	MaterialUtils.SetColorRGBA(self._smrender, shadowColId, 0.6980392156862745, 0.6470588235294118, 0.7058823529411765, 1)
	MaterialUtils.SetFloat(self._smrender, "_RampThreshold", 0.2)
	MaterialUtils.SetFloat(self._smrender, "_RampSmooth", 0.4)
	MaterialUtils.SetColorRGBA(self._smrender, rimColorId, 0.30196078431372547, 0.4470588235294118, 0.4235294117647059, 1)
	MaterialUtils.SetFloat(self._smrender, "_RimThreshold", 0.532)
	MaterialUtils.SetFloat(self._smrender, "_RimSmooth", 0.42)
	MaterialUtils.SetFloat(self._smrender, "_OutlineWidth", 0.006)
	MaterialUtils.SetColorRGBA(self._smrender, outlineColorId, 0.1607843137254902, 0.1607843137254902, 0.1607843137254902, 1)
end

function Avatar:_onSkeletonLoaded(resLoader)
	if resLoader == self._resLoader then
		self:_clearLastCombition()

		self._skeletonsMap = {}

		local go = self:getGameObject()

		GoUtil.TravelTransform(go.transform, function(tf)
			self._skeletonsMap[tf.name] = tf
		end)
		self:setParent(self.parent)
		self:setLayer(self.layer)
		self:_initAnimatorConfig()
		self.dispatch(self, Avatar.OnSkeletonLoaded, self)

		if self:isPartsLoaded() then
			self:_clearLastCombition()
			self:_clearCombition()
			self:detachAllParts()
			self.dispatch(self, Avatar.OnAvatarLoaded, self)
		end
	end
end

function Avatar:_onAvatarEnabled()
	self:updateMountingLayer()
end

function Avatar:_initAnimatorConfig()
	local go = self:getGameObject()

	self._bonesRef = go:GetComponent(ComponentType.BonesRef)

	if self._bonesRef and self._bonesRef.bones.Length > 0 then
		self._mountSycBone = self._bonesRef.bones[0]
	end

	local animator = go:GetComponent(ComponentType.Animator)

	self._animatorUpdateMode = animator.updateMode
	self._animatorCullingMode = animator.cullingMode

	self:setAnimator(animator)
	self:updateMountingLayer()
end

function Avatar:_buildSkinMeshRenderer()
	local go = self:getGameObject()
	local render = go:GetComponent(ComponentType.SkinnedMeshRenderer)

	if render then
		UnityEngine.GameObject.DestroyImmediate(render)
	end

	self._smrender = go:AddComponent(ComponentType.SkinnedMeshRenderer)
end

function Avatar:_initAnimatorLayers()
	if not self._animator then
		return
	end

	if not self._animLayers then
		local layerCount = self._animator.layerCount

		for i = 0, layerCount - 1 do
			self._animLayers = self._animLayers or {}

			local name = self._animator:GetLayerName(i)

			self._animLayers[name] = i
		end
	end

	self.mountLayerIndex = -1

	if self._animLayers and not string.nilorempty(self._mountLayer) then
		self.mountLayerIndex = self._animLayers[self._mountLayer]
	end

	self:parseParams()
end

function Avatar:_createCreateRoleMat(_call_back)
	if self._matRes then
		if _call_back then
			_call_back()
		end

		return
	end

	if not self.avatarMo then
		return
	end

	local skelCo = AvatarConfig.instance:getSkelCo(self.avatarMo.skeleton)

	if self.avatarMo then
		if not self.avatarMo.gender then
			local _gender = skelCo.gender

			if self._updateMatForUI then
				if not self._showRoleMat then
					local _matRole = self._createRoleMat

					print("crcrcr light self._updateMatForUI:", self._updateMatForUI, _gender)

					if _matRole[_gender + 1] then
						self._matResLoader = MultiResLoader.New()
						self._matResourcesList = {}

						for i, v in ipairs(_matRole[_gender + 1]) do
							if self._updateMatForUI then
								if v and v[3] then
									table.insert(self._matResourcesList, v[3])
									print("crcrcr light v[3] kkk:", v[3])
								end
							elseif v and v[3] and v[4] then
								table.insert(self._matResourcesList, (self._farCamera or nil) and (v[3] or v[4]))
								print("crcrcr light v[3]:", (self._farCamera or nil) and (v[3] or v[4]))
							end
						end
					end

					self._matResLoader:setResPaths(self._matResourcesList)
					self._matResLoader:load(function()
						self._matRes = {}

						for i = 1, #self._matResourcesList do
							self._matRes[i] = self._matResLoader:getResource(self._matResourcesList[i])

							print("crcrcr light self._matRes[i]:", self._matRes[i])
						end

						if _call_back then
							_call_back()
						end
					end, nil, self)
				end
			end
		end
	end
end

function Avatar:_updateMatForRoleModel()
	if not self.avatarMo then
		return
	end

	local skelCo = AvatarConfig.instance:getSkelCo(self.avatarMo.skeleton)

	if self.avatarMo then
		if not self.avatarMo.gender then
			local _gender = skelCo.gender

			if self._updateMatForUI then
				if not self._showRoleMat then
					local _matRole = self._createRoleMat

					if self.parts then
						for partType, part in pairs(self.parts) do
							if part then
								local _matInfo, _matInfoOrder

								for k, v in pairs(_matRole[_gender + 1]) do
									if v and v[1] == part.partType then
										_matInfo = v
										_matInfoOrder = k

										break
									end
								end

								print("crcrcr _matInfo:", _matInfo and _matInfo[3], _matInfo and _matInfo[4], _matInfoOrder, partType, part)

								if _matInfoOrder and _matInfo and _matInfo[3] then
									local _partGo = part._resLoader:getGameObject()

									print("crcrcr _partGo:", _partGo, partType, part, part._resLoader)

									local _partChild

									if _partGo then
										_partChild = _matInfo[2] == "" and _partGo or GameUtil.findChildEx(_partGo.gameObject, _matInfo[2])

										print("crcrcr partpart _partChild:", part.partType, _partChild, _partChild.name)
									end

									if _partChild then
										local render = _partChild:GetComponent(ComponentType.SkinnedMeshRenderer)

										print("crcrcr render:", render and render.material)

										if render and render.material then
											if Avatar.DebugParam then
												local var_42_2 = self._matRes

												if self._matRes then
													var_42_2 = self._matRes[_matInfoOrder]

													if self._matRes[_matInfoOrder] then
														local _matAsset = self._matRes[_matInfoOrder]:GetMainAsset()

														print("crcrcr partpart _matAsset:", _matAsset, _matInfoOrder, self._matRes, self._matRes[_matInfoOrder])

														if _matAsset then
															print("crcrcr light _matInfoOrder:", _matInfoOrder, ", _partChild.name:", _partChild.name, ", self._matRes:", self._matRes)

															render.material = _matAsset
														end
													end
												end
											else
												local _shaderParam

												if self._updateMatForUI then
													_shaderParam = _matInfo[3]

													printf("crcrcr _shaderParam 111:", _matInfo[3])
												else
													_shaderParam = self._farCamera and _matInfo[3] or _matInfo[4]

													printf("crcrcr _shaderParam 222:", _shaderParam)
												end

												GoUtil.SetMatColor(render.material, "_Color", _shaderParam[1], _shaderParam[2], _shaderParam[3], _shaderParam[4])
												render.material:SetFloat("_AmbientIntensity", _shaderParam[5])
												GoUtil.SetMatColor(render.material, "_Specular", _shaderParam[6], _shaderParam[7], _shaderParam[8], _shaderParam[9])
												render.material:SetFloat("_SpecularScale", _shaderParam[10])
												render.material:SetFloat("_SpecularArea", _shaderParam[11])
												GoUtil.SetMatColor(render.material, "_ShadowColor", _shaderParam[12], _shaderParam[13], _shaderParam[14], _shaderParam[15])
												render.material:SetFloat("_ShadowIntensity", _shaderParam[16])
												render.material:SetFloat("_ShadowArea", _shaderParam[17])

												if self._removeRim then
													GoUtil.SetMatColor(render.material, "_RimColor", 0, 0, 0, 0)
												else
													GoUtil.SetMatColor(render.material, "_RimColor", _shaderParam[18], _shaderParam[19], _shaderParam[20], _shaderParam[21])
												end

												render.material:SetFloat("_RimThreshold", _shaderParam[22])
												render.material:SetFloat("_RimSmooth", _shaderParam[23])
												GoUtil.SetMatColor(render.material, "_OutlineColor", _shaderParam[24], _shaderParam[25], _shaderParam[26], _shaderParam[27])
												render.material:SetFloat("_Outline", _shaderParam[28])
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function Avatar:updateMatByPart(_farCamera)
	if _farCamera ~= self._farCamera then
		self:_clearCreateRoleMatRes()
	end

	self._updateMatForUI = false
	self._farCamera = _farCamera

	print("crcrcr light updateMatByPart:", self._farCamera)

	if Avatar.DebugParam then
		self:_createCreateRoleMat(function()
			self:_updateMatForRoleModel()
		end)
	else
		self:_updateMatForRoleModel()
	end
end

function Avatar:updateMatByPartForUI(_removeRim)
	self._updateMatForUI = true
	self._farCamera = true
	self._removeRim = _removeRim

	print("crcrcr light updateMatByPart 2222:", self._farCamera)

	if Avatar.DebugParam then
		self:_createCreateRoleMat(function()
			self:_updateMatForRoleModel()
		end)
	else
		self:_updateMatForRoleModel()
	end
end

function Avatar:_clearCreateRoleMatRes()
	if self._matResLoader then
		GameUtil.unloadMultiResLoaderResource(self._matResLoader)

		self._matResLoader = nil
	end

	if self._matRes then
		for i = 1, #self._matRes do
			if self._matRes[i] ~= nil then
				self._matRes[i] = nil
			end
		end

		self._matRes = nil
	end
end

function Avatar:_onSkinedMeshLoaded(part)
	local isAvatarLoaded = self:isSkelegonLoaded() and self:isPartsLoaded()

	if self.avatarType == AvatarType.UI then
		part:sharedSkeletons(self._skeletonsMap)
	elseif isAvatarLoaded then
		self:_clearLastCombition()
		self:_clearCombition()
		AvatarCombitionMgr.instance:combine(self)
	end

	if isAvatarLoaded then
		self.dispatch(self, Avatar.OnAvatarLoaded, self)
	end
end

function Avatar:_clearLastCombition()
	self:_clearSkmRender(self._lastSmrenderer)

	if self._lastCombition then
		AvatarCombitionMgr.instance:removeCombition(self._lastCombition)

		self._lastCombition = nil
	end

	self._lastSmrenderer = nil
end

function Avatar:_clearCombition()
	self:_clearSkmRender(self._smrender)

	if self._combition then
		AvatarCombitionMgr.instance:removeCombition(self._combition)

		self._combition = nil
	end

	self._smrender = nil
end

function Avatar:_clearSkmRender(smrender)
	if smrender then
		local material = smrender.material

		smrender.material.mainTexture = nil
		smrender.sharedMesh = nil
		smrender.material = nil

		UnityEngine.GameObject.DestroyImmediate(material)
		UnityEngine.GameObject.DestroyImmediate(smrender)
	end
end

function Avatar:setMount(assetPath, mountLayer)
	self._mountModel = assetPath

	if string.nilorempty(mountLayer) then
		self._mountLayer = AnimatorHash.mountLayer or mountLayer
	end

	self:_initAnimatorLayers()
end

function Avatar:startMount()
	if not self.isMounted and not string.nilorempty(self._mountModel) then
		self.isMounted = true

		self.mount:load(self._mountModel)
	end
end

function Avatar:dismount()
	if not self.isMounted then
		return
	end

	self.isMounted = nil

	if self._animator then
		self._animator.updateMode = self._animatorUpdateMode
		self._animator.cullingMode = self._animatorCullingMode
	end

	if self._syncMout then
		self._syncMout.enabled = false
	end

	if self.avatarMo then
		self.avatarMo.isMount = nil
	end

	self:setParent(self.parent)
	self:updateMountingLayer()
	self.mount:detach()
end

function Avatar:isMountLoaded()
	return not self.isMounted or string.nilorempty(self._mountModel) or self.mount:isMountLoaded()
end

function Avatar:_startMounting()
	self:updateMountPoint()

	local mountAnim = self.mount:getAnimator()

	self._animator.updateMode = mountAnim.updateMode
	self._animator.cullingMode = mountAnim.cullingMode

	self:updateMountingLayer()
	self.mount:playMountingEff()
	self:_endMounting()
end

function Avatar:updateMountPoint()
	if not self.isMounted then
		return
	end

	self.mount:setParent(self.parent)
	self._resLoader:setParent(self.mount.mountPoint.transform)

	if self._mountSycBone then
		local go = self:getGameObject()

		self._syncMout = SyncPositionByBones.Get(go)
		self._syncMout.originBone = self.mount.mountPoint.transform
		self._syncMout.targetBone = self._mountSycBone

		self:getSkeletonObject():setRotation(90, 0, 0)

		self._syncMout.enabled = true

		go.transform:SetParent(self.parent)
	end
end

function Avatar:updateMountingLayer()
	self:_initAnimatorLayers()

	if not self._animator or not self._animator.isActiveAndEnabled or not self._animLayers or not self.mountLayerIndex or self.mountLayerIndex == -1 then
		return
	end

	if self.isMounted and not string.nilorempty(self._mountModel) then
		for k, v in pairs(self._animLayers) do
			self:setLayerWeight(v, self.mountLayerIndex == v and 1 or 0)
		end
	else
		for k, v in pairs(self._animLayers) do
			self:setLayerWeight(v, v == 0 and 1 or 0)
		end
	end
end

function Avatar:_endMounting()
	self:syncMountAnim()
	self:syncMountPosition()
end

function Avatar:_onMountLoaded(mount)
	if self.mount == mount then
		self:_startMounting()
		self:_buildMountEffects()
	end
end

function Avatar:_onRecycleMountResObject(loader, obj)
	if self.parent then
		self._resLoader:setParent(self.parent)
	end
end

function Avatar:_buildMountEffects()
	self.mount:clearEffects()

	local mountCo = self:_getMountCo()

	if not mountCo then
		return
	end

	local effConfig

	if self.avatarType == AvatarType.UI then
		effConfig = mountCo.effects_hpm
	end

	effConfig = effConfig or mountCo.effects

	if not effConfig or #effConfig == 0 then
		return
	end

	for i = 1, #effConfig do
		local path, hagPoint, effType = self:_parseEffParams(effConfig[i])

		if (self.avatarType ~= AvatarType.UI or effType ~= AvatarFXEffType.WalkOnly) and path and hagPoint then
			if not string.find(path, ".prefab") then
				path = path .. ".prefab"
			end

			self.mount:setEffect("effect/prefabs/zuoqi/" .. path, hagPoint, effType)
		end
	end
end

function Avatar:_parseEffParams(effConfig)
	if string.nilorempty(effConfig) then
		return
	end

	local cfgs = string.split(effConfig, ",")

	return cfgs[1], cfgs[2], checknumber(cfgs[3] or 0)
end

function Avatar:syncMountAnim()
	if not self.isMounted or not self.mountLayerIndex or self.mountLayerIndex == -1 or not self._currAnim then
		return
	end

	local animMount

	if self.mount then
		animMount = self.mount:getAnimator()
	end

	local animator = self:getAnimator()

	if not animMount or not animator then
		return
	end

	local normalizedTimeMount = animMount:GetCurrentAnimatorStateInfo(0).normalizedTime
	local normalizedTime = animator:GetCurrentAnimatorStateInfo(self.mountLayerIndex).normalizedTime

	if math.abs(normalizedTimeMount - normalizedTime) > 0.001 then
		animator:CrossFade(self._currAnim, 0.1, self.mountLayerIndex, normalizedTimeMount)
	end
end

function Avatar:syncMountPosition()
	return
end

function Avatar:play(currAnim)
	self._currAnim = currAnim

	if self.isMounted then
		self:playAnim(currAnim, self.mountLayerIndex, 0)
	else
		self.playAnim(self, self, currAnim, 0, 0)
	end

	if self.mount and self.isMounted then
		self.mount:play(currAnim, 0, 0)
	end
end

function Avatar:crossFadeInFixedTime(currAnim, crossFadeFixed)
	if self.isMounted then
		Avatar.super.crossFadeInFixedTime(self, currAnim, self.mountLayerIndex, crossFadeFixed, 0)
	else
		Avatar.super.crossFadeInFixedTime(self, currAnim, 0, crossFadeFixed, 0)
	end

	if self.mount and self.isMounted then
		self.mount:crossFadeInFixedTime(currAnim, 0, crossFadeFixed, 0)
	end
end

function Avatar:setBool(id, val)
	Avatar.super.setBool(self, id, val)

	if self.mount and self.isMounted then
		self.mount:setBool(id, val)
	end
end

function Avatar:setInteger(id, val)
	Avatar.super.setInteger(self, id, val)

	if self.mount and self.isMounted then
		self.mount:setInteger(id, val)
	end
end

function Avatar:setFloat(id, val)
	Avatar.super.setFloat(self, id, val)

	if self.mount and self.isMounted then
		self.mount:setFloat(id, val)
	end
end

function Avatar:setTrigger(id)
	Avatar.super.setTrigger(self, id, val)

	if self.mount and self.isMounted then
		self.mount:setTrigger(id, val)
	end
end

return Avatar
