-- chunkname: @/tmp/or_script/lua_compile/cocos/cocostudio/DeprecatedCocoStudioClass.lua

if ccs == nil then
	return
end

DeprecatedExtensionClass = {} or DeprecatedExtensionClass

local function deprecatedTip(old_name, new_name)
	print("\n********** \n" .. old_name .. " was deprecated please use " .. new_name .. " instead.\n**********")
end

function DeprecatedExtensionClass.CCArmature()
	deprecatedTip("CCArmature", "ccs.Armature")

	return ccs.Armature
end

_G.CCArmature = DeprecatedExtensionClass.CCArmature()

function DeprecatedExtensionClass.CCArmatureAnimation()
	deprecatedTip("CCArmatureAnimation", "ccs.ArmatureAnimation")

	return ccs.ArmatureAnimation
end

_G.CCArmatureAnimation = DeprecatedExtensionClass.CCArmatureAnimation()

function DeprecatedExtensionClass.CCSkin()
	deprecatedTip("CCSkin", "ccs.Skin")

	return ccs.Skin
end

_G.CCSkin = DeprecatedExtensionClass.CCSkin()

function DeprecatedExtensionClass.CCBone()
	deprecatedTip("CCBone", "ccs.Bone")

	return ccs.Bone
end

_G.CCBone = DeprecatedExtensionClass.CCBone()

function DeprecatedExtensionClass.CCArmatureDataManager()
	deprecatedTip("CCArmatureDataManager", "ccs.ArmatureDataManager")

	return ccs.ArmatureDataManager
end

_G.CCArmatureDataManager = DeprecatedExtensionClass.CCArmatureDataManager()

function DeprecatedExtensionClass.CCBatchNode()
	deprecatedTip("CCBatchNode", "ccs.BatchNode")

	return ccs.BatchNode
end

_G.CCBatchNode = DeprecatedExtensionClass.CCBatchNode()

function DeprecatedExtensionClass.CCTween()
	deprecatedTip("CCTween", "ccs.Tween")

	return ccs.Tween
end

_G.CCTween = DeprecatedExtensionClass.CCTween()

function DeprecatedExtensionClass.CCBaseData()
	deprecatedTip("CCBaseData", "ccs.BaseData")

	return ccs.BaseData
end

_G.CCBaseData = DeprecatedExtensionClass.CCBaseData()

function DeprecatedExtensionClass.CCDisplayManager()
	deprecatedTip("CCDisplayManager", "ccs.DisplayManager")

	return ccs.DisplayManager
end

_G.CCDisplayManager = DeprecatedExtensionClass.CCDisplayManager()

function DeprecatedExtensionClass.UIHelper()
	deprecatedTip("UIHelper", "ccs.UIHelper")

	return ccs.UIHelper
end

_G.UIHelper = DeprecatedExtensionClass.UIHelper()

function DeprecatedExtensionClass.UILayout()
	deprecatedTip("UILayout", "ccs.UILayout")

	return ccs.UILayout
end

_G.UILayout = DeprecatedExtensionClass.UILayout()

function DeprecatedExtensionClass.UIWidget()
	deprecatedTip("UIWidget", "ccs.UIWidget")

	return ccs.UIWidget
end

_G.UIWidget = DeprecatedExtensionClass.UIWidget()

function DeprecatedExtensionClass.UILayer()
	deprecatedTip("UILayer", "ccs.UILayer")

	return ccs.UILayer
end

_G.UILayer = DeprecatedExtensionClass.UILayer()

function DeprecatedExtensionClass.UIButton()
	deprecatedTip("UIButton", "ccs.UIButton")

	return ccs.UIButton
end

_G.UIButton = DeprecatedExtensionClass.UIButton()

function DeprecatedExtensionClass.UICheckBox()
	deprecatedTip("UICheckBox", "ccs.UICheckBox")

	return ccs.UICheckBox
end

_G.UICheckBox = DeprecatedExtensionClass.UICheckBox()

function DeprecatedExtensionClass.UIImageView()
	deprecatedTip("UIImageView", "ccs.UIImageView")

	return ccs.UIImageView
end

_G.UIImageView = DeprecatedExtensionClass.UIImageView()

function DeprecatedExtensionClass.UILabel()
	deprecatedTip("UILabel", "ccs.UILabel")

	return ccs.UILabel
end

_G.UILabel = DeprecatedExtensionClass.UILabel()

function DeprecatedExtensionClass.UILabelAtlas()
	deprecatedTip("UILabelAtlas", "ccs.UILabelAtlas")

	return ccs.UILabelAtlas
end

_G.UILabelAtlas = DeprecatedExtensionClass.UILabelAtlas()

function DeprecatedExtensionClass.UILabelBMFont()
	deprecatedTip("UILabelBMFont", "ccs.UILabelBMFont")

	return ccs.UILabelBMFont
end

_G.UILabelBMFont = DeprecatedExtensionClass.UILabelBMFont()

function DeprecatedExtensionClass.UILoadingBar()
	deprecatedTip("UILoadingBar", "ccs.UILoadingBar")

	return ccs.UILoadingBar
end

_G.UILoadingBar = DeprecatedExtensionClass.UILoadingBar()

function DeprecatedExtensionClass.UISlider()
	deprecatedTip("UISlider", "ccs.UISlider")

	return ccs.UISlider
end

_G.UISlider = DeprecatedExtensionClass.UISlider()

function DeprecatedExtensionClass.UITextField()
	deprecatedTip("UITextField", "ccs.UITextField")

	return ccs.UITextField
end

_G.UITextField = DeprecatedExtensionClass.UITextField()

function DeprecatedExtensionClass.UIScrollView()
	deprecatedTip("UIScrollView", "ccs.UIScrollView")

	return ccs.UIScrollView
end

_G.UIScrollView = DeprecatedExtensionClass.UIScrollView()

function DeprecatedExtensionClass.UIPageView()
	deprecatedTip("UIPageView", "ccs.UIPageView")

	return ccs.UIPageView
end

_G.UIPageView = DeprecatedExtensionClass.UIPageView()

function DeprecatedExtensionClass.UIListView()
	deprecatedTip("UIListView", "ccs.UIListView")

	return ccs.UIListView
end

_G.UIListView = DeprecatedExtensionClass.UIListView()

function DeprecatedExtensionClass.UILayoutParameter()
	deprecatedTip("UILayoutParameter", "ccs.UILayoutParameter")

	return ccs.UILayoutParameter
end

_G.UILayoutParameter = DeprecatedExtensionClass.UILayoutParameter()

function DeprecatedExtensionClass.UILinearLayoutParameter()
	deprecatedTip("UILinearLayoutParameter", "ccs.UILinearLayoutParameter")

	return ccs.UILinearLayoutParameter
end

_G.UILinearLayoutParameter = DeprecatedExtensionClass.UILinearLayoutParameter()

function DeprecatedExtensionClass.UIRelativeLayoutParameter()
	deprecatedTip("UIRelativeLayoutParameter", "ccs.UIRelativeLayoutParameter")

	return ccs.UIRelativeLayoutParameter
end

_G.UIRelativeLayoutParameter = DeprecatedExtensionClass.UIRelativeLayoutParameter()

function DeprecatedExtensionClass.CCComController()
	deprecatedTip("CCComController", "ccs.ComController")

	return ccs.CCComController
end

_G.CCComController = DeprecatedExtensionClass.CCComController()

function DeprecatedExtensionClass.CCComAudio()
	deprecatedTip("CCComAudio", "ccs.ComAudio")

	return ccs.ComAudio
end

_G.CCComAudio = DeprecatedExtensionClass.CCComAudio()

function DeprecatedExtensionClass.CCComAttribute()
	deprecatedTip("CCComAttribute", "ccs.ComAttribute")

	return ccs.ComAttribute
end

_G.CCComAttribute = DeprecatedExtensionClass.CCComAttribute()

function DeprecatedExtensionClass.CCComRender()
	deprecatedTip("CCComRender", "ccs.ComRender")

	return ccs.ComRender
end

_G.CCComRender = DeprecatedExtensionClass.CCComRender()

function DeprecatedExtensionClass.ActionManager()
	deprecatedTip("ActionManager", "ccs.ActionManagerEx")

	return ccs.ActionManagerEx
end

_G.ActionManager = DeprecatedExtensionClass.ActionManager()

function DeprecatedExtensionClass.SceneReader()
	deprecatedTip("SceneReader", "ccs.SceneReader")

	return ccs.SceneReader
end

_G.SceneReader = DeprecatedExtensionClass.SceneReader()

function DeprecatedExtensionClass.GUIReader()
	deprecatedTip("GUIReader", "ccs.GUIReader")

	return ccs.GUIReader
end

_G.GUIReader = DeprecatedExtensionClass.GUIReader()

function DeprecatedExtensionClass.UIRootWidget()
	deprecatedTip("UIRootWidget", "ccs.UIRootWidget")

	return ccs.UIRootWidget
end

_G.UIRootWidget = DeprecatedExtensionClass.UIRootWidget()

function DeprecatedExtensionClass.ActionObject()
	deprecatedTip("ActionObject", "ccs.ActionObject")

	return ccs.ActionObject
end

_G.ActionObject = DeprecatedExtensionClass.ActionObject()
