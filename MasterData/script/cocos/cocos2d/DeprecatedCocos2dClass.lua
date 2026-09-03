-- chunkname: @/tmp/or_script/lua_compile/cocos/cocos2d/DeprecatedCocos2dClass.lua

DeprecatedClass = {} or DeprecatedClass

local function deprecatedTip(old_name, new_name)
	print("\n********** \n" .. old_name .. " was deprecated please use " .. new_name .. " instead.\n**********")
end

function DeprecatedClass.CCProgressTo()
	deprecatedTip("CCProgressTo", "cc.ProgressTo")

	return cc.ProgressTo
end

_G.CCProgressTo = DeprecatedClass.CCProgressTo()

function DeprecatedClass.CCHide()
	deprecatedTip("CCHide", "cc.Hide")

	return cc.Hide
end

_G.CCHide = DeprecatedClass.CCHide()

function DeprecatedClass.CCTransitionMoveInB()
	deprecatedTip("CCTransitionMoveInB", "cc.TransitionMoveInB")

	return cc.TransitionMoveInB
end

_G.CCTransitionMoveInB = DeprecatedClass.CCTransitionMoveInB()

function DeprecatedClass.CCEaseSineIn()
	deprecatedTip("CCEaseSineIn", "cc.EaseSineIn")

	return cc.EaseSineIn
end

_G.CCEaseSineIn = DeprecatedClass.CCEaseSineIn()

function DeprecatedClass.CCTransitionMoveInL()
	deprecatedTip("CCTransitionMoveInL", "cc.TransitionMoveInL")

	return cc.TransitionMoveInL
end

_G.CCTransitionMoveInL = DeprecatedClass.CCTransitionMoveInL()

function DeprecatedClass.CCEaseInOut()
	deprecatedTip("CCEaseInOut", "cc.EaseInOut")

	return cc.EaseInOut
end

_G.CCEaseInOut = DeprecatedClass.CCEaseInOut()

function DeprecatedClass.CCTransitionMoveInT()
	deprecatedTip("CCTransitionMoveInT", "cc.TransitionMoveInT")

	return cc.TransitionMoveInT
end

_G.CCTransitionMoveInT = DeprecatedClass.CCTransitionMoveInT()

function DeprecatedClass.CCTransitionMoveInR()
	deprecatedTip("CCTransitionMoveInR", "cc.TransitionMoveInR")

	return cc.TransitionMoveInR
end

_G.CCTransitionMoveInR = DeprecatedClass.CCTransitionMoveInR()

function DeprecatedClass.CCParticleSnow()
	deprecatedTip("CCParticleSnow", "cc.ParticleSnow")

	return cc.ParticleSnow
end

_G.CCParticleSnow = DeprecatedClass.CCParticleSnow()

function DeprecatedClass.CCActionCamera()
	deprecatedTip("CCActionCamera", "cc.ActionCamera")

	return cc.ActionCamera
end

_G.CCActionCamera = DeprecatedClass.CCActionCamera()

function DeprecatedClass.CCProgressFromTo()
	deprecatedTip("CCProgressFromTo", "cc.ProgressFromTo")

	return cc.ProgressFromTo
end

_G.CCProgressFromTo = DeprecatedClass.CCProgressFromTo()

function DeprecatedClass.CCMoveTo()
	deprecatedTip("CCMoveTo", "cc.MoveTo")

	return cc.MoveTo
end

_G.CCMoveTo = DeprecatedClass.CCMoveTo()

function DeprecatedClass.CCJumpBy()
	deprecatedTip("CCJumpBy", "cc.JumpBy")

	return cc.JumpBy
end

_G.CCJumpBy = DeprecatedClass.CCJumpBy()

function DeprecatedClass.CCObject()
	deprecatedTip("CCObject", "cc.Object")

	return cc.Object
end

_G.CCObject = DeprecatedClass.CCObject()

function DeprecatedClass.CCTransitionRotoZoom()
	deprecatedTip("CCTransitionRotoZoom", "cc.TransitionRotoZoom")

	return cc.TransitionRotoZoom
end

_G.CCTransitionRotoZoom = DeprecatedClass.CCTransitionRotoZoom()

function DeprecatedClass.CCDirector()
	deprecatedTip("CCDirector", "cc.Director")

	return cc.Director
end

_G.CCDirector = DeprecatedClass.CCDirector()

function DeprecatedClass.CCScheduler()
	deprecatedTip("CCScheduler", "cc.Scheduler")

	return cc.Scheduler
end

_G.CCScheduler = DeprecatedClass.CCScheduler()

function DeprecatedClass.CCEaseElasticOut()
	deprecatedTip("CCEaseElasticOut", "cc.EaseElasticOut")

	return cc.EaseElasticOut
end

_G.CCEaseElasticOut = DeprecatedClass.CCEaseElasticOut()

function DeprecatedClass.CCTableViewCell()
	deprecatedTip("CCTableViewCell", "cc.TableViewCell")

	return cc.TableViewCell
end

_G.CCTableViewCell = DeprecatedClass.CCTableViewCell()

function DeprecatedClass.CCEaseBackOut()
	deprecatedTip("CCEaseBackOut", "cc.EaseBackOut")

	return cc.EaseBackOut
end

_G.CCEaseBackOut = DeprecatedClass.CCEaseBackOut()

function DeprecatedClass.CCParticleSystemQuad()
	deprecatedTip("CCParticleSystemQuad", "cc.ParticleSystemQuad")

	return cc.ParticleSystemQuad
end

_G.CCParticleSystemQuad = DeprecatedClass.CCParticleSystemQuad()

function DeprecatedClass.CCMenuItemToggle()
	deprecatedTip("CCMenuItemToggle", "cc.MenuItemToggle")

	return cc.MenuItemToggle
end

_G.CCMenuItemToggle = DeprecatedClass.CCMenuItemToggle()

function DeprecatedClass.CCStopGrid()
	deprecatedTip("CCStopGrid", "cc.StopGrid")

	return cc.StopGrid
end

_G.CCStopGrid = DeprecatedClass.CCStopGrid()

function DeprecatedClass.CCTransitionScene()
	deprecatedTip("CCTransitionScene", "cc.TransitionScene")

	return cc.TransitionScene
end

_G.CCTransitionScene = DeprecatedClass.CCTransitionScene()

function DeprecatedClass.CCSkewBy()
	deprecatedTip("CCSkewBy", "cc.SkewBy")

	return cc.SkewBy
end

_G.CCSkewBy = DeprecatedClass.CCSkewBy()

function DeprecatedClass.CCLayer()
	deprecatedTip("CCLayer", "cc.Layer")

	return cc.Layer
end

_G.CCLayer = DeprecatedClass.CCLayer()

function DeprecatedClass.CCEaseElastic()
	deprecatedTip("CCEaseElastic", "cc.EaseElastic")

	return cc.EaseElastic
end

_G.CCEaseElastic = DeprecatedClass.CCEaseElastic()

function DeprecatedClass.CCTMXTiledMap()
	deprecatedTip("CCTMXTiledMap", "cc.TMXTiledMap")

	return cc.TMXTiledMap
end

_G.CCTMXTiledMap = DeprecatedClass.CCTMXTiledMap()

function DeprecatedClass.CCGrid3DAction()
	deprecatedTip("CCGrid3DAction", "cc.Grid3DAction")

	return cc.Grid3DAction
end

_G.CCGrid3DAction = DeprecatedClass.CCGrid3DAction()

function DeprecatedClass.CCFadeIn()
	deprecatedTip("CCFadeIn", "cc.FadeIn")

	return cc.FadeIn
end

_G.CCFadeIn = DeprecatedClass.CCFadeIn()

function DeprecatedClass.CCNodeRGBA()
	deprecatedTip("CCNodeRGBA", "cc.Node")

	return cc.Node
end

_G.CCNodeRGBA = DeprecatedClass.CCNodeRGBA()

function DeprecatedClass.NodeRGBA()
	deprecatedTip("cc.NodeRGBA", "cc.Node")

	return cc.Node
end

_G.cc.NodeRGBA = DeprecatedClass.NodeRGBA()

function DeprecatedClass.CCAnimationCache()
	deprecatedTip("CCAnimationCache", "cc.AnimationCache")

	return cc.AnimationCache
end

_G.CCAnimationCache = DeprecatedClass.CCAnimationCache()

function DeprecatedClass.CCFlipY3D()
	deprecatedTip("CCFlipY3D", "cc.FlipY3D")

	return cc.FlipY3D
end

_G.CCFlipY3D = DeprecatedClass.CCFlipY3D()

function DeprecatedClass.CCEaseSineInOut()
	deprecatedTip("CCEaseSineInOut", "cc.EaseSineInOut")

	return cc.EaseSineInOut
end

_G.CCEaseSineInOut = DeprecatedClass.CCEaseSineInOut()

function DeprecatedClass.CCTransitionFlipAngular()
	deprecatedTip("CCTransitionFlipAngular", "cc.TransitionFlipAngular")

	return cc.TransitionFlipAngular
end

_G.CCTransitionFlipAngular = DeprecatedClass.CCTransitionFlipAngular()

function DeprecatedClass.CCEaseElasticInOut()
	deprecatedTip("CCEaseElasticInOut", "cc.EaseElasticInOut")

	return cc.EaseElasticInOut
end

_G.CCEaseElasticInOut = DeprecatedClass.CCEaseElasticInOut()

function DeprecatedClass.CCEaseBounce()
	deprecatedTip("CCEaseBounce", "cc.EaseBounce")

	return cc.EaseBounce
end

_G.CCEaseBounce = DeprecatedClass.CCEaseBounce()

function DeprecatedClass.CCShow()
	deprecatedTip("CCShow", "cc.Show")

	return cc.Show
end

_G.CCShow = DeprecatedClass.CCShow()

function DeprecatedClass.CCFadeOut()
	deprecatedTip("CCFadeOut", "cc.FadeOut")

	return cc.FadeOut
end

_G.CCFadeOut = DeprecatedClass.CCFadeOut()

function DeprecatedClass.CCCallFunc()
	deprecatedTip("CCCallFunc", "cc.CallFunc")

	return cc.CallFunc
end

_G.CCCallFunc = DeprecatedClass.CCCallFunc()

function DeprecatedClass.CCWaves3D()
	deprecatedTip("CCWaves3D", "cc.Waves3D")

	return cc.Waves3D
end

_G.CCWaves3D = DeprecatedClass.CCWaves3D()

function DeprecatedClass.CCFlipX3D()
	deprecatedTip("CCFlipX3D", "cc.FlipX3D")

	return cc.FlipX3D
end

_G.CCFlipX3D = DeprecatedClass.CCFlipX3D()

function DeprecatedClass.CCParticleFireworks()
	deprecatedTip("CCParticleFireworks", "cc.ParticleFireworks")

	return cc.ParticleFireworks
end

_G.CCParticleFireworks = DeprecatedClass.CCParticleFireworks()

function DeprecatedClass.CCMenuItemImage()
	deprecatedTip("CCMenuItemImage", "cc.MenuItemImage")

	return cc.MenuItemImage
end

_G.CCMenuItemImage = DeprecatedClass.CCMenuItemImage()

function DeprecatedClass.CCParticleFire()
	deprecatedTip("CCParticleFire", "cc.ParticleFire")

	return cc.ParticleFire
end

_G.CCParticleFire = DeprecatedClass.CCParticleFire()

function DeprecatedClass.CCMenuItem()
	deprecatedTip("CCMenuItem", "cc.MenuItem")

	return cc.MenuItem
end

_G.CCMenuItem = DeprecatedClass.CCMenuItem()

function DeprecatedClass.CCActionEase()
	deprecatedTip("CCActionEase", "cc.ActionEase")

	return cc.ActionEase
end

_G.CCActionEase = DeprecatedClass.CCActionEase()

function DeprecatedClass.CCTransitionSceneOriented()
	deprecatedTip("CCTransitionSceneOriented", "cc.TransitionSceneOriented")

	return cc.TransitionSceneOriented
end

_G.CCTransitionSceneOriented = DeprecatedClass.CCTransitionSceneOriented()

function DeprecatedClass.CCTransitionZoomFlipAngular()
	deprecatedTip("CCTransitionZoomFlipAngular", "cc.TransitionZoomFlipAngular")

	return cc.TransitionZoomFlipAngular
end

_G.CCTransitionZoomFlipAngular = DeprecatedClass.CCTransitionZoomFlipAngular()

function DeprecatedClass.CCEaseIn()
	deprecatedTip("CCEaseIn", "cc.EaseIn")

	return cc.EaseIn
end

_G.CCEaseIn = DeprecatedClass.CCEaseIn()

function DeprecatedClass.CCEaseExponentialInOut()
	deprecatedTip("CCEaseExponentialInOut", "cc.EaseExponentialInOut")

	return cc.EaseExponentialInOut
end

_G.CCEaseExponentialInOut = DeprecatedClass.CCEaseExponentialInOut()

function DeprecatedClass.CCTransitionFlipX()
	deprecatedTip("CCTransitionFlipX", "cc.TransitionFlipX")

	return cc.TransitionFlipX
end

_G.CCTransitionFlipX = DeprecatedClass.CCTransitionFlipX()

function DeprecatedClass.CCEaseExponentialOut()
	deprecatedTip("CCEaseExponentialOut", "cc.EaseExponentialOut")

	return cc.EaseExponentialOut
end

_G.CCEaseExponentialOut = DeprecatedClass.CCEaseExponentialOut()

function DeprecatedClass.CCLabel()
	deprecatedTip("CCLabel", "cc.Label")

	return cc.Label
end

_G.CCLabel = DeprecatedClass.CCLabel()

function DeprecatedClass.CCApplication()
	deprecatedTip("CCApplication", "cc.Application")

	return cc.Application
end

_G.CCApplication = DeprecatedClass.CCApplication()

function DeprecatedClass.CCDelayTime()
	deprecatedTip("CCDelayTime", "cc.DelayTime")

	return cc.DelayTime
end

_G.CCDelayTime = DeprecatedClass.CCDelayTime()

function DeprecatedClass.CCLabelAtlas()
	deprecatedTip("CCLabelAtlas", "cc.LabelAtlas")

	return cc.LabelAtlas
end

_G.CCLabelAtlas = DeprecatedClass.CCLabelAtlas()

function DeprecatedClass.CCLabelBMFont()
	deprecatedTip("CCLabelBMFont", "cc.LabelBMFont")

	return cc.LabelBMFont
end

_G.CCLabelBMFont = DeprecatedClass.CCLabelBMFont()

function DeprecatedClass.CCFadeOutTRTiles()
	deprecatedTip("CCFadeOutTRTiles", "cc.FadeOutTRTiles")

	return cc.FadeOutTRTiles
end

_G.CCFadeOutTRTiles = DeprecatedClass.CCFadeOutTRTiles()

function DeprecatedClass.CCEaseElasticIn()
	deprecatedTip("CCEaseElasticIn", "cc.EaseElasticIn")

	return cc.EaseElasticIn
end

_G.CCEaseElasticIn = DeprecatedClass.CCEaseElasticIn()

function DeprecatedClass.CCParticleSpiral()
	deprecatedTip("CCParticleSpiral", "cc.ParticleSpiral")

	return cc.ParticleSpiral
end

_G.CCParticleSpiral = DeprecatedClass.CCParticleSpiral()

function DeprecatedClass.CCFiniteTimeAction()
	deprecatedTip("CCFiniteTimeAction", "cc.FiniteTimeAction")

	return cc.FiniteTimeAction
end

_G.CCFiniteTimeAction = DeprecatedClass.CCFiniteTimeAction()

function DeprecatedClass.CCFadeOutDownTiles()
	deprecatedTip("CCFadeOutDownTiles", "cc.FadeOutDownTiles")

	return cc.FadeOutDownTiles
end

_G.CCFadeOutDownTiles = DeprecatedClass.CCFadeOutDownTiles()

function DeprecatedClass.CCJumpTiles3D()
	deprecatedTip("CCJumpTiles3D", "cc.JumpTiles3D")

	return cc.JumpTiles3D
end

_G.CCJumpTiles3D = DeprecatedClass.CCJumpTiles3D()

function DeprecatedClass.CCEaseBackIn()
	deprecatedTip("CCEaseBackIn", "cc.EaseBackIn")

	return cc.EaseBackIn
end

_G.CCEaseBackIn = DeprecatedClass.CCEaseBackIn()

function DeprecatedClass.CCSpriteBatchNode()
	deprecatedTip("CCSpriteBatchNode", "cc.SpriteBatchNode")

	return cc.SpriteBatchNode
end

_G.CCSpriteBatchNode = DeprecatedClass.CCSpriteBatchNode()

function DeprecatedClass.CCParticleSystem()
	deprecatedTip("CCParticleSystem", "cc.ParticleSystem")

	return cc.ParticleSystem
end

_G.CCParticleSystem = DeprecatedClass.CCParticleSystem()

function DeprecatedClass.CCActionTween()
	deprecatedTip("CCActionTween", "cc.ActionTween")

	return cc.ActionTween
end

_G.CCActionTween = DeprecatedClass.CCActionTween()

function DeprecatedClass.CCTransitionFadeDown()
	deprecatedTip("CCTransitionFadeDown", "cc.TransitionFadeDown")

	return cc.TransitionFadeDown
end

_G.CCTransitionFadeDown = DeprecatedClass.CCTransitionFadeDown()

function DeprecatedClass.CCParticleSun()
	deprecatedTip("CCParticleSun", "cc.ParticleSun")

	return cc.ParticleSun
end

_G.CCParticleSun = DeprecatedClass.CCParticleSun()

function DeprecatedClass.CCTransitionProgressHorizontal()
	deprecatedTip("CCTransitionProgressHorizontal", "cc.TransitionProgressHorizontal")

	return cc.TransitionProgressHorizontal
end

_G.CCTransitionProgressHorizontal = DeprecatedClass.CCTransitionProgressHorizontal()

function DeprecatedClass.CCRipple3D()
	deprecatedTip("CCRipple3D", "cc.Ripple3D")

	return cc.Ripple3D
end

_G.CCRipple3D = DeprecatedClass.CCRipple3D()

function DeprecatedClass.CCTMXLayer()
	deprecatedTip("CCTMXLayer", "cc.TMXLayer")

	return cc.TMXLayer
end

_G.CCTMXLayer = DeprecatedClass.CCTMXLayer()

function DeprecatedClass.CCFlipX()
	deprecatedTip("CCFlipX", "cc.FlipX")

	return cc.FlipX
end

_G.CCFlipX = DeprecatedClass.CCFlipX()

function DeprecatedClass.CCFlipY()
	deprecatedTip("CCFlipY", "cc.FlipY")

	return cc.FlipY
end

_G.CCFlipY = DeprecatedClass.CCFlipY()

function DeprecatedClass.CCTransitionSplitCols()
	deprecatedTip("CCTransitionSplitCols", "cc.TransitionSplitCols")

	return cc.TransitionSplitCols
end

_G.CCTransitionSplitCols = DeprecatedClass.CCTransitionSplitCols()

function DeprecatedClass.CCTimer()
	deprecatedTip("CCTimer", "cc.Timer")

	return cc.Timer
end

_G.CCTimer = DeprecatedClass.CCTimer()

function DeprecatedClass.CCFadeTo()
	deprecatedTip("CCFadeTo", "cc.FadeTo")

	return cc.FadeTo
end

_G.CCFadeTo = DeprecatedClass.CCFadeTo()

function DeprecatedClass.CCRepeatForever()
	deprecatedTip("CCRepeatForever", "cc.RepeatForever")

	return cc.RepeatForever
end

_G.CCRepeatForever = DeprecatedClass.CCRepeatForever()

function DeprecatedClass.CCPlace()
	deprecatedTip("CCPlace", "cc.Place")

	return cc.Place
end

_G.CCPlace = DeprecatedClass.CCPlace()

function DeprecatedClass.CCGLProgram()
	deprecatedTip("CCGLProgram", "cc.GLProgram")

	return cc.GLProgram
end

_G.CCGLProgram = DeprecatedClass.CCGLProgram()

function DeprecatedClass.CCEaseBounceOut()
	deprecatedTip("CCEaseBounceOut", "cc.EaseBounceOut")

	return cc.EaseBounceOut
end

_G.CCEaseBounceOut = DeprecatedClass.CCEaseBounceOut()

function DeprecatedClass.CCCardinalSplineBy()
	deprecatedTip("CCCardinalSplineBy", "cc.CardinalSplineBy")

	return cc.CardinalSplineBy
end

_G.CCCardinalSplineBy = DeprecatedClass.CCCardinalSplineBy()

function DeprecatedClass.CCSpriteFrameCache()
	deprecatedTip("CCSpriteFrameCache", "cc.SpriteFrameCache")

	return cc.SpriteFrameCache
end

_G.CCSpriteFrameCache = DeprecatedClass.CCSpriteFrameCache()

function DeprecatedClass.CCTransitionShrinkGrow()
	deprecatedTip("CCTransitionShrinkGrow", "cc.TransitionShrinkGrow")

	return cc.TransitionShrinkGrow
end

_G.CCTransitionShrinkGrow = DeprecatedClass.CCTransitionShrinkGrow()

function DeprecatedClass.CCSplitCols()
	deprecatedTip("CCSplitCols", "cc.SplitCols")

	return cc.SplitCols
end

_G.CCSplitCols = DeprecatedClass.CCSplitCols()

function DeprecatedClass.CCClippingNode()
	deprecatedTip("CCClippingNode", "cc.ClippingNode")

	return cc.ClippingNode
end

_G.CCClippingNode = DeprecatedClass.CCClippingNode()

function DeprecatedClass.CCEaseBounceInOut()
	deprecatedTip("CCEaseBounceInOut", "cc.EaseBounceInOut")

	return cc.EaseBounceInOut
end

_G.CCEaseBounceInOut = DeprecatedClass.CCEaseBounceInOut()

function DeprecatedClass.CCLiquid()
	deprecatedTip("CCLiquid", "cc.Liquid")

	return cc.Liquid
end

_G.CCLiquid = DeprecatedClass.CCLiquid()

function DeprecatedClass.CCParticleFlower()
	deprecatedTip("CCParticleFlower", "cc.ParticleFlower")

	return cc.ParticleFlower
end

_G.CCParticleFlower = DeprecatedClass.CCParticleFlower()

function DeprecatedClass.CCParticleSmoke()
	deprecatedTip("CCParticleSmoke", "cc.ParticleSmoke")

	return cc.ParticleSmoke
end

_G.CCParticleSmoke = DeprecatedClass.CCParticleSmoke()

function DeprecatedClass.CCImage()
	deprecatedTip("CCImage", "cc.Image")

	return cc.Image
end

_G.CCImage = DeprecatedClass.CCImage()

function DeprecatedClass.CCTurnOffTiles()
	deprecatedTip("CCTurnOffTiles", "cc.TurnOffTiles")

	return cc.TurnOffTiles
end

_G.CCTurnOffTiles = DeprecatedClass.CCTurnOffTiles()

function DeprecatedClass.CCBlink()
	deprecatedTip("CCBlink", "cc.Blink")

	return cc.Blink
end

_G.CCBlink = DeprecatedClass.CCBlink()

function DeprecatedClass.CCShaderCache()
	deprecatedTip("CCShaderCache", "cc.ShaderCache")

	return cc.ShaderCache
end

_G.CCShaderCache = DeprecatedClass.CCShaderCache()

function DeprecatedClass.CCJumpTo()
	deprecatedTip("CCJumpTo", "cc.JumpTo")

	return cc.JumpTo
end

_G.CCJumpTo = DeprecatedClass.CCJumpTo()

function DeprecatedClass.CCAtlasNode()
	deprecatedTip("CCAtlasNode", "cc.AtlasNode")

	return cc.AtlasNode
end

_G.CCAtlasNode = DeprecatedClass.CCAtlasNode()

function DeprecatedClass.CCTransitionJumpZoom()
	deprecatedTip("CCTransitionJumpZoom", "cc.TransitionJumpZoom")

	return cc.TransitionJumpZoom
end

_G.CCTransitionJumpZoom = DeprecatedClass.CCTransitionJumpZoom()

function DeprecatedClass.CCTransitionProgressVertical()
	deprecatedTip("CCTransitionProgressVertical", "cc.TransitionProgressVertical")

	return cc.TransitionProgressVertical
end

_G.CCTransitionProgressVertical = DeprecatedClass.CCTransitionProgressVertical()

function DeprecatedClass.CCAnimationFrame()
	deprecatedTip("CCAnimationFrame", "cc.AnimationFrame")

	return cc.AnimationFrame
end

_G.CCAnimationFrame = DeprecatedClass.CCAnimationFrame()

function DeprecatedClass.CCTintTo()
	deprecatedTip("CCTintTo", "cc.TintTo")

	return cc.TintTo
end

_G.CCTintTo = DeprecatedClass.CCTintTo()

function DeprecatedClass.CCTiledGrid3DAction()
	deprecatedTip("CCTiledGrid3DAction", "cc.TiledGrid3DAction")

	return cc.TiledGrid3DAction
end

_G.CCTiledGrid3DAction = DeprecatedClass.CCTiledGrid3DAction()

function DeprecatedClass.CCTMXTilesetInfo()
	deprecatedTip("CCTMXTilesetInfo", "cc.TMXTilesetInfo")

	return cc.TMXTilesetInfo
end

_G.CCTMXTilesetInfo = DeprecatedClass.CCTMXTilesetInfo()

function DeprecatedClass.CCTMXObjectGroup()
	deprecatedTip("CCTMXObjectGroup", "cc.TMXObjectGroup")

	return cc.TMXObjectGroup
end

_G.CCTMXObjectGroup = DeprecatedClass.CCTMXObjectGroup()

function DeprecatedClass.CCParticleGalaxy()
	deprecatedTip("CCParticleGalaxy", "cc.ParticleGalaxy")

	return cc.ParticleGalaxy
end

_G.CCParticleGalaxy = DeprecatedClass.CCParticleGalaxy()

function DeprecatedClass.CCTwirl()
	deprecatedTip("CCTwirl", "cc.Twirl")

	return cc.Twirl
end

_G.CCTwirl = DeprecatedClass.CCTwirl()

function DeprecatedClass.CCMenuItemLabel()
	deprecatedTip("CCMenuItemLabel", "cc.MenuItemLabel")

	return cc.MenuItemLabel
end

_G.CCMenuItemLabel = DeprecatedClass.CCMenuItemLabel()

function DeprecatedClass.CCLayerColor()
	deprecatedTip("CCLayerColor", "cc.LayerColor")

	return cc.LayerColor
end

_G.CCLayerColor = DeprecatedClass.CCLayerColor()

function DeprecatedClass.CCFadeOutBLTiles()
	deprecatedTip("CCFadeOutBLTiles", "cc.FadeOutBLTiles")

	return cc.FadeOutBLTiles
end

_G.CCFadeOutBLTiles = DeprecatedClass.CCFadeOutBLTiles()

function DeprecatedClass.CCTransitionProgress()
	deprecatedTip("CCTransitionProgress", "cc.TransitionProgress")

	return cc.TransitionProgress
end

_G.CCTransitionProgress = DeprecatedClass.CCTransitionProgress()

function DeprecatedClass.CCEaseRateAction()
	deprecatedTip("CCEaseRateAction", "cc.EaseRateAction")

	return cc.EaseRateAction
end

_G.CCEaseRateAction = DeprecatedClass.CCEaseRateAction()

function DeprecatedClass.CCLayerGradient()
	deprecatedTip("CCLayerGradient", "cc.LayerGradient")

	return cc.LayerGradient
end

_G.CCLayerGradient = DeprecatedClass.CCLayerGradient()

function DeprecatedClass.CCMenuItemSprite()
	deprecatedTip("CCMenuItemSprite", "cc.MenuItemSprite")

	return cc.MenuItemSprite
end

_G.CCMenuItemSprite = DeprecatedClass.CCMenuItemSprite()

function DeprecatedClass.CCNode()
	deprecatedTip("CCNode", "cc.Node")

	return cc.Node
end

_G.CCNode = DeprecatedClass.CCNode()

function DeprecatedClass.CCToggleVisibility()
	deprecatedTip("CCToggleVisibility", "cc.ToggleVisibility")

	return cc.ToggleVisibility
end

_G.CCToggleVisibility = DeprecatedClass.CCToggleVisibility()

function DeprecatedClass.CCRepeat()
	deprecatedTip("CCRepeat", "cc.Repeat")

	return cc.Repeat
end

_G.CCRepeat = DeprecatedClass.CCRepeat()

function DeprecatedClass.CCRenderTexture()
	deprecatedTip("CCRenderTexture", "cc.RenderTexture")

	return cc.RenderTexture
end

_G.CCRenderTexture = DeprecatedClass.CCRenderTexture()

function DeprecatedClass.CCTransitionFlipY()
	deprecatedTip("CCTransitionFlipY", "cc.TransitionFlipY")

	return cc.TransitionFlipY
end

_G.CCTransitionFlipY = DeprecatedClass.CCTransitionFlipY()

function DeprecatedClass.CCLayerMultiplex()
	deprecatedTip("CCLayerMultiplex", "cc.LayerMultiplex")

	return cc.LayerMultiplex
end

_G.CCLayerMultiplex = DeprecatedClass.CCLayerMultiplex()

function DeprecatedClass.CCTMXLayerInfo()
	deprecatedTip("CCTMXLayerInfo", "cc.TMXLayerInfo")

	return cc.TMXLayerInfo
end

_G.CCTMXLayerInfo = DeprecatedClass.CCTMXLayerInfo()

function DeprecatedClass.CCEaseBackInOut()
	deprecatedTip("CCEaseBackInOut", "cc.EaseBackInOut")

	return cc.EaseBackInOut
end

_G.CCEaseBackInOut = DeprecatedClass.CCEaseBackInOut()

function DeprecatedClass.CCActionInstant()
	deprecatedTip("CCActionInstant", "cc.ActionInstant")

	return cc.ActionInstant
end

_G.CCActionInstant = DeprecatedClass.CCActionInstant()

function DeprecatedClass.CCTargetedAction()
	deprecatedTip("CCTargetedAction", "cc.TargetedAction")

	return cc.TargetedAction
end

_G.CCTargetedAction = DeprecatedClass.CCTargetedAction()

function DeprecatedClass.CCDrawNode()
	deprecatedTip("CCDrawNode", "cc.DrawNode")

	return cc.DrawNode
end

_G.CCDrawNode = DeprecatedClass.CCDrawNode()

function DeprecatedClass.CCTransitionTurnOffTiles()
	deprecatedTip("CCTransitionTurnOffTiles", "cc.TransitionTurnOffTiles")

	return cc.TransitionTurnOffTiles
end

_G.CCTransitionTurnOffTiles = DeprecatedClass.CCTransitionTurnOffTiles()

function DeprecatedClass.CCRotateTo()
	deprecatedTip("CCRotateTo", "cc.RotateTo")

	return cc.RotateTo
end

_G.CCRotateTo = DeprecatedClass.CCRotateTo()

function DeprecatedClass.CCTransitionSplitRows()
	deprecatedTip("CCTransitionSplitRows", "cc.TransitionSplitRows")

	return cc.TransitionSplitRows
end

_G.CCTransitionSplitRows = DeprecatedClass.CCTransitionSplitRows()

function DeprecatedClass.CCTransitionProgressRadialCCW()
	deprecatedTip("CCTransitionProgressRadialCCW", "cc.TransitionProgressRadialCCW")

	return cc.TransitionProgressRadialCCW
end

_G.CCTransitionProgressRadialCCW = DeprecatedClass.CCTransitionProgressRadialCCW()

function DeprecatedClass.CCScaleTo()
	deprecatedTip("CCScaleTo", "cc.ScaleTo")

	return cc.ScaleTo
end

_G.CCScaleTo = DeprecatedClass.CCScaleTo()

function DeprecatedClass.CCTransitionPageTurn()
	deprecatedTip("CCTransitionPageTurn", "cc.TransitionPageTurn")

	return cc.TransitionPageTurn
end

_G.CCTransitionPageTurn = DeprecatedClass.CCTransitionPageTurn()

function DeprecatedClass.CCParticleExplosion()
	deprecatedTip("CCParticleExplosion", "cc.ParticleExplosion")

	return cc.ParticleExplosion
end

_G.CCParticleExplosion = DeprecatedClass.CCParticleExplosion()

function DeprecatedClass.CCMenu()
	deprecatedTip("CCMenu", "cc.Menu")

	return cc.Menu
end

_G.CCMenu = DeprecatedClass.CCMenu()

function DeprecatedClass.CCTexture2D()
	deprecatedTip("CCTexture2D", "cc.Texture2D")

	return cc.Texture2D
end

_G.CCTexture2D = DeprecatedClass.CCTexture2D()

function DeprecatedClass.CCActionManager()
	deprecatedTip("CCActionManager", "cc.ActionManager")

	return cc.ActionManager
end

_G.CCActionManager = DeprecatedClass.CCActionManager()

function DeprecatedClass.CCParticleBatchNode()
	deprecatedTip("CCParticleBatchNode", "cc.ParticleBatchNode")

	return cc.ParticleBatchNode
end

_G.CCParticleBatchNode = DeprecatedClass.CCParticleBatchNode()

function DeprecatedClass.CCTransitionZoomFlipX()
	deprecatedTip("CCTransitionZoomFlipX", "cc.TransitionZoomFlipX")

	return cc.TransitionZoomFlipX
end

_G.CCTransitionZoomFlipX = DeprecatedClass.CCTransitionZoomFlipX()

function DeprecatedClass.CCScaleBy()
	deprecatedTip("CCScaleBy", "cc.ScaleBy")

	return cc.ScaleBy
end

_G.CCScaleBy = DeprecatedClass.CCScaleBy()

function DeprecatedClass.CCTileMapAtlas()
	deprecatedTip("CCTileMapAtlas", "cc.TileMapAtlas")

	return cc.TileMapAtlas
end

_G.CCTileMapAtlas = DeprecatedClass.CCTileMapAtlas()

function DeprecatedClass.CCAction()
	deprecatedTip("CCAction", "cc.Action")

	return cc.Action
end

_G.CCAction = DeprecatedClass.CCAction()

function DeprecatedClass.CCLens3D()
	deprecatedTip("CCLens3D", "cc.Lens3D")

	return cc.Lens3D
end

_G.CCLens3D = DeprecatedClass.CCLens3D()

function DeprecatedClass.CCAnimation()
	deprecatedTip("CCAnimation", "cc.Animation")

	return cc.Animation
end

_G.CCAnimation = DeprecatedClass.CCAnimation()

function DeprecatedClass.CCTransitionSlideInT()
	deprecatedTip("CCTransitionSlideInT", "cc.TransitionSlideInT")

	return cc.TransitionSlideInT
end

_G.CCTransitionSlideInT = DeprecatedClass.CCTransitionSlideInT()

function DeprecatedClass.CCSpawn()
	deprecatedTip("CCSpawn", "cc.Spawn")

	return cc.Spawn
end

_G.CCSpawn = DeprecatedClass.CCSpawn()

function DeprecatedClass.CCSet()
	deprecatedTip("CCSet", "cc.Set")

	return cc.Set
end

_G.CCSet = DeprecatedClass.CCSet()

function DeprecatedClass.CCShakyTiles3D()
	deprecatedTip("CCShakyTiles3D", "cc.ShakyTiles3D")

	return cc.ShakyTiles3D
end

_G.CCShakyTiles3D = DeprecatedClass.CCShakyTiles3D()

function DeprecatedClass.CCPageTurn3D()
	deprecatedTip("CCPageTurn3D", "cc.PageTurn3D")

	return cc.PageTurn3D
end

_G.CCPageTurn3D = DeprecatedClass.CCPageTurn3D()

function DeprecatedClass.CCGrid3D()
	deprecatedTip("CCGrid3D", "cc.Grid3D")

	return cc.Grid3D
end

_G.CCGrid3D = DeprecatedClass.CCGrid3D()

function DeprecatedClass.CCTransitionProgressInOut()
	deprecatedTip("CCTransitionProgressInOut", "cc.TransitionProgressInOut")

	return cc.TransitionProgressInOut
end

_G.CCTransitionProgressInOut = DeprecatedClass.CCTransitionProgressInOut()

function DeprecatedClass.CCTransitionFadeBL()
	deprecatedTip("CCTransitionFadeBL", "cc.TransitionFadeBL")

	return cc.TransitionFadeBL
end

_G.CCTransitionFadeBL = DeprecatedClass.CCTransitionFadeBL()

function DeprecatedClass.CCCamera()
	deprecatedTip("CCCamera", "cc.Camera")

	return cc.Camera
end

_G.CCCamera = DeprecatedClass.CCCamera()

function DeprecatedClass.CCLayerRGBA()
	deprecatedTip("CCLayerRGBA", "cc.Layer")

	return cc.Layer
end

_G.CCLayerRGBA = DeprecatedClass.CCLayerRGBA()

function DeprecatedClass.LayerRGBA()
	deprecatedTip("cc.LayerRGBA", "cc.Layer")

	return cc.Layer
end

_G.cc.LayerRGBA = DeprecatedClass.LayerRGBA()

function DeprecatedClass.CCBezierTo()
	deprecatedTip("CCBezierTo", "cc.BezierTo")

	return cc.BezierTo
end

_G.CCBezierTo = DeprecatedClass.CCBezierTo()

function DeprecatedClass.CCFollow()
	deprecatedTip("CCFollow", "cc.Follow")

	return cc.Follow
end

_G.CCFollow = DeprecatedClass.CCFollow()

function DeprecatedClass.CCTintBy()
	deprecatedTip("CCTintBy", "cc.TintBy")

	return cc.TintBy
end

_G.CCTintBy = DeprecatedClass.CCTintBy()

function DeprecatedClass.CCActionInterval()
	deprecatedTip("CCActionInterval", "cc.ActionInterval")

	return cc.ActionInterval
end

_G.CCActionInterval = DeprecatedClass.CCActionInterval()

function DeprecatedClass.CCAnimate()
	deprecatedTip("CCAnimate", "cc.Animate")

	return cc.Animate
end

_G.CCAnimate = DeprecatedClass.CCAnimate()

function DeprecatedClass.CCProgressTimer()
	deprecatedTip("CCProgressTimer", "cc.ProgressTimer")

	return cc.ProgressTimer
end

_G.CCProgressTimer = DeprecatedClass.CCProgressTimer()

function DeprecatedClass.CCParticleMeteor()
	deprecatedTip("CCParticleMeteor", "cc.ParticleMeteor")

	return cc.ParticleMeteor
end

_G.CCParticleMeteor = DeprecatedClass.CCParticleMeteor()

function DeprecatedClass.CCTransitionFadeTR()
	deprecatedTip("CCTransitionFadeTR", "cc.TransitionFadeTR")

	return cc.TransitionFadeTR
end

_G.CCTransitionFadeTR = DeprecatedClass.CCTransitionFadeTR()

function DeprecatedClass.CCCatmullRomTo()
	deprecatedTip("CCCatmullRomTo", "cc.CatmullRomTo")

	return cc.CatmullRomTo
end

_G.CCCatmullRomTo = DeprecatedClass.CCCatmullRomTo()

function DeprecatedClass.CCTransitionZoomFlipY()
	deprecatedTip("CCTransitionZoomFlipY", "cc.TransitionZoomFlipY")

	return cc.TransitionZoomFlipY
end

_G.CCTransitionZoomFlipY = DeprecatedClass.CCTransitionZoomFlipY()

function DeprecatedClass.CCTransitionCrossFade()
	deprecatedTip("CCTransitionCrossFade", "cc.TransitionCrossFade")

	return cc.TransitionCrossFade
end

_G.CCTransitionCrossFade = DeprecatedClass.CCTransitionCrossFade()

function DeprecatedClass.CCGridBase()
	deprecatedTip("CCGridBase", "cc.GridBase")

	return cc.GridBase
end

_G.CCGridBase = DeprecatedClass.CCGridBase()

function DeprecatedClass.CCSkewTo()
	deprecatedTip("CCSkewTo", "cc.SkewTo")

	return cc.SkewTo
end

_G.CCSkewTo = DeprecatedClass.CCSkewTo()

function DeprecatedClass.CCCardinalSplineTo()
	deprecatedTip("CCCardinalSplineTo", "cc.CardinalSplineTo")

	return cc.CardinalSplineTo
end

_G.CCCardinalSplineTo = DeprecatedClass.CCCardinalSplineTo()

function DeprecatedClass.CCTMXMapInfo()
	deprecatedTip("CCTMXMapInfo", "cc.TMXMapInfo")

	return cc.TMXMapInfo
end

_G.CCTMXMapInfo = DeprecatedClass.CCTMXMapInfo()

function DeprecatedClass.CCEaseExponentialIn()
	deprecatedTip("CCEaseExponentialIn", "cc.EaseExponentialIn")

	return cc.EaseExponentialIn
end

_G.CCEaseExponentialIn = DeprecatedClass.CCEaseExponentialIn()

function DeprecatedClass.CCReuseGrid()
	deprecatedTip("CCReuseGrid", "cc.ReuseGrid")

	return cc.ReuseGrid
end

_G.CCReuseGrid = DeprecatedClass.CCReuseGrid()

function DeprecatedClass.CCMenuItemAtlasFont()
	deprecatedTip("CCMenuItemAtlasFont", "cc.MenuItemAtlasFont")

	return cc.MenuItemAtlasFont
end

_G.CCMenuItemAtlasFont = DeprecatedClass.CCMenuItemAtlasFont()

function DeprecatedClass.CCSpriteFrame()
	deprecatedTip("CCSpriteFrame", "cc.SpriteFrame")

	return cc.SpriteFrame
end

_G.CCSpriteFrame = DeprecatedClass.CCSpriteFrame()

function DeprecatedClass.CCSplitRows()
	deprecatedTip("CCSplitRows", "cc.SplitRows")

	return cc.SplitRows
end

_G.CCSplitRows = DeprecatedClass.CCSplitRows()

function DeprecatedClass.CCSprite()
	deprecatedTip("CCSprite", "cc.Sprite")

	return cc.Sprite
end

_G.CCSprite = DeprecatedClass.CCSprite()

function DeprecatedClass.CCOrbitCamera()
	deprecatedTip("CCOrbitCamera", "cc.OrbitCamera")

	return cc.OrbitCamera
end

_G.CCOrbitCamera = DeprecatedClass.CCOrbitCamera()

function DeprecatedClass.CCUserDefault()
	deprecatedTip("CCUserDefault", "cc.UserDefault")

	return cc.UserDefault
end

_G.CCUserDefault = DeprecatedClass.CCUserDefault()

function DeprecatedClass.CCFadeOutUpTiles()
	deprecatedTip("CCFadeOutUpTiles", "cc.FadeOutUpTiles")

	return cc.FadeOutUpTiles
end

_G.CCFadeOutUpTiles = DeprecatedClass.CCFadeOutUpTiles()

function DeprecatedClass.CCParticleRain()
	deprecatedTip("CCParticleRain", "cc.ParticleRain")

	return cc.ParticleRain
end

_G.CCParticleRain = DeprecatedClass.CCParticleRain()

function DeprecatedClass.CCWaves()
	deprecatedTip("CCWaves", "cc.Waves")

	return cc.Waves
end

_G.CCWaves = DeprecatedClass.CCWaves()

function DeprecatedClass.CCEaseOut()
	deprecatedTip("CCEaseOut", "cc.EaseOut")

	return cc.EaseOut
end

_G.CCEaseOut = DeprecatedClass.CCEaseOut()

function DeprecatedClass.CCEaseBounceIn()
	deprecatedTip("CCEaseBounceIn", "cc.EaseBounceIn")

	return cc.EaseBounceIn
end

_G.CCEaseBounceIn = DeprecatedClass.CCEaseBounceIn()

function DeprecatedClass.CCMenuItemFont()
	deprecatedTip("CCMenuItemFont", "cc.MenuItemFont")

	return cc.MenuItemFont
end

_G.CCMenuItemFont = DeprecatedClass.CCMenuItemFont()

function DeprecatedClass.CCEaseSineOut()
	deprecatedTip("CCEaseSineOut", "cc.EaseSineOut")

	return cc.EaseSineOut
end

_G.CCEaseSineOut = DeprecatedClass.CCEaseSineOut()

function DeprecatedClass.CCTextureCache()
	deprecatedTip("CCTextureCache", "cc.TextureCache")

	return cc.TextureCache
end

_G.CCTextureCache = DeprecatedClass.CCTextureCache()

function DeprecatedClass.CCTiledGrid3D()
	deprecatedTip("CCTiledGrid3D", "cc.TiledGrid3D")

	return cc.TiledGrid3D
end

_G.CCTiledGrid3D = DeprecatedClass.CCTiledGrid3D()

function DeprecatedClass.CCRemoveSelf()
	deprecatedTip("CCRemoveSelf", "cc.RemoveSelf")

	return cc.RemoveSelf
end

_G.CCRemoveSelf = DeprecatedClass.CCRemoveSelf()

function DeprecatedClass.CCLabelTTF()
	deprecatedTip("CCLabelTTF", "cc.LabelTTF")

	return cc.LabelTTF
end

_G.CCLabelTTF = DeprecatedClass.CCLabelTTF()

function DeprecatedClass.CCTouch()
	deprecatedTip("CCTouch", "cc.Touch")

	return cc.Touch
end

_G.CCTouch = DeprecatedClass.CCTouch()

function DeprecatedClass.CCMoveBy()
	deprecatedTip("CCMoveBy", "cc.MoveBy")

	return cc.MoveBy
end

_G.CCMoveBy = DeprecatedClass.CCMoveBy()

function DeprecatedClass.CCMotionStreak()
	deprecatedTip("CCMotionStreak", "cc.MotionStreak")

	return cc.MotionStreak
end

_G.CCMotionStreak = DeprecatedClass.CCMotionStreak()

function DeprecatedClass.CCRotateBy()
	deprecatedTip("CCRotateBy", "cc.RotateBy")

	return cc.RotateBy
end

_G.CCRotateBy = DeprecatedClass.CCRotateBy()

function DeprecatedClass.CCFileUtils()
	deprecatedTip("CCFileUtils", "cc.FileUtils")

	return cc.FileUtils
end

_G.CCFileUtils = DeprecatedClass.CCFileUtils()

function DeprecatedClass.CCBezierBy()
	deprecatedTip("CCBezierBy", "cc.BezierBy")

	return cc.BezierBy
end

_G.CCBezierBy = DeprecatedClass.CCBezierBy()

function DeprecatedClass.CCTransitionFade()
	deprecatedTip("CCTransitionFade", "cc.TransitionFade")

	return cc.TransitionFade
end

_G.CCTransitionFade = DeprecatedClass.CCTransitionFade()

function DeprecatedClass.CCTransitionProgressOutIn()
	deprecatedTip("CCTransitionProgressOutIn", "cc.TransitionProgressOutIn")

	return cc.TransitionProgressOutIn
end

_G.CCTransitionProgressOutIn = DeprecatedClass.CCTransitionProgressOutIn()

function DeprecatedClass.CCCatmullRomBy()
	deprecatedTip("CCCatmullRomBy", "cc.CatmullRomBy")

	return cc.CatmullRomBy
end

_G.CCCatmullRomBy = DeprecatedClass.CCCatmullRomBy()

function DeprecatedClass.CCGridAction()
	deprecatedTip("CCGridAction", "cc.GridAction")

	return cc.GridAction
end

_G.CCGridAction = DeprecatedClass.CCGridAction()

function DeprecatedClass.CCShaky3D()
	deprecatedTip("CCShaky3D", "cc.Shaky3D")

	return cc.Shaky3D
end

_G.CCShaky3D = DeprecatedClass.CCShaky3D()

function DeprecatedClass.CCTransitionEaseScene()
	deprecatedTip("CCTransitionEaseScene", "cc.TransitionEaseScene")

	return cc.TransitionEaseScene
end

_G.CCTransitionEaseScene = DeprecatedClass.CCTransitionEaseScene()

function DeprecatedClass.CCSequence()
	deprecatedTip("CCSequence", "cc.Sequence")

	return cc.Sequence
end

_G.CCSequence = DeprecatedClass.CCSequence()

function DeprecatedClass.CCTransitionFadeUp()
	deprecatedTip("CCTransitionFadeUp", "cc.TransitionFadeUp")

	return cc.TransitionFadeUp
end

_G.CCTransitionFadeUp = DeprecatedClass.CCTransitionFadeUp()

function DeprecatedClass.CCTransitionProgressRadialCW()
	deprecatedTip("CCTransitionProgressRadialCW", "cc.TransitionProgressRadialCW")

	return cc.TransitionProgressRadialCW
end

_G.CCTransitionProgressRadialCW = DeprecatedClass.CCTransitionProgressRadialCW()

function DeprecatedClass.CCShuffleTiles()
	deprecatedTip("CCShuffleTiles", "cc.ShuffleTiles")

	return cc.ShuffleTiles
end

_G.CCShuffleTiles = DeprecatedClass.CCShuffleTiles()

function DeprecatedClass.CCTransitionSlideInR()
	deprecatedTip("CCTransitionSlideInR", "cc.TransitionSlideInR")

	return cc.TransitionSlideInR
end

_G.CCTransitionSlideInR = DeprecatedClass.CCTransitionSlideInR()

function DeprecatedClass.CCScene()
	deprecatedTip("CCScene", "cc.Scene")

	return cc.Scene
end

_G.CCScene = DeprecatedClass.CCScene()

function DeprecatedClass.CCParallaxNode()
	deprecatedTip("CCParallaxNode", "cc.ParallaxNode")

	return cc.ParallaxNode
end

_G.CCParallaxNode = DeprecatedClass.CCParallaxNode()

function DeprecatedClass.CCTransitionSlideInL()
	deprecatedTip("CCTransitionSlideInL", "cc.TransitionSlideInL")

	return cc.TransitionSlideInL
end

_G.CCTransitionSlideInL = DeprecatedClass.CCTransitionSlideInL()

function DeprecatedClass.CCWavesTiles3D()
	deprecatedTip("CCWavesTiles3D", "cc.WavesTiles3D")

	return cc.WavesTiles3D
end

_G.CCWavesTiles3D = DeprecatedClass.CCWavesTiles3D()

function DeprecatedClass.CCTransitionSlideInB()
	deprecatedTip("CCTransitionSlideInB", "cc.TransitionSlideInB")

	return cc.TransitionSlideInB
end

_G.CCTransitionSlideInB = DeprecatedClass.CCTransitionSlideInB()

function DeprecatedClass.CCSpeed()
	deprecatedTip("CCSpeed", "cc.Speed")

	return cc.Speed
end

_G.CCSpeed = DeprecatedClass.CCSpeed()

function DeprecatedClass.CCShatteredTiles3D()
	deprecatedTip("CCShatteredTiles3D", "cc.ShatteredTiles3D")

	return cc.ShatteredTiles3D
end

_G.CCShatteredTiles3D = DeprecatedClass.CCShatteredTiles3D()

function DeprecatedClass.CCCallFuncN()
	deprecatedTip("CCCallFuncN", "cc.CallFunc")

	return cc.CallFunc
end

_G.CCCallFuncN = DeprecatedClass.CCCallFuncN()

function DeprecatedClass.CCEGLViewProtocol()
	deprecatedTip("CCEGLViewProtocol", "cc.GLViewProtocol")

	return cc.GLViewProtocol
end

_G.CCEGLViewProtocol = DeprecatedClass.CCEGLViewProtocol()

function DeprecatedClass.CCEGLView()
	deprecatedTip("CCEGLView", "cc.GLView")

	return cc.GLView
end

_G.CCEGLView = DeprecatedClass.CCEGLView()

function DeprecatedClass.XMLHttpRequest()
	deprecatedTip("XMLHttpRequest", "cc.XMLHttpRequest")

	return cc.XMLHttpRequest
end

_G.XMLHttpRequest = DeprecatedClass.XMLHttpRequest()

function DeprecatedClass.EGLViewProtocol()
	deprecatedTip("cc.EGLViewProtocol", "cc.GLViewProtocol")

	return cc.GLViewProtocol
end

_G["cc.EGLViewProtocol"] = DeprecatedClass.EGLViewProtocol()

function DeprecatedClass.EGLView()
	deprecatedTip("cc.EGLView", "cc.GLView")

	return cc.GLView
end

_G["cc.EGLView"] = DeprecatedClass.EGLView()

function DeprecatedClass.EGLView()
	deprecatedTip("cc.EGLView", "cc.GLView")
	print(cc.GLView)

	return cc.GLView
end

_G["cc.EGLView"] = DeprecatedClass.EGLView()

function DeprecatedClass.ShaderCache()
	deprecatedTip("cc.ShaderCache", "cc.GLProgramCache")

	return cc.GLProgramCache
end

cc.ShaderCache = DeprecatedClass.ShaderCache()
