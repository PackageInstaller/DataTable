-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawCardOptUpDlg.lua

local DrawCardConfig = require("DesignerScript/DrawCardConfig")
local DrawCardShowPanel = require("UI/DrawCard/DrawCardShowPanel")
local GameSettings = require("Helper/GameSettings")
local strClassName = "DrawCardOptUpDlg"
local DrawCardOptUpDlg = Class(strClassName, UIControls.Window)
local SLIDE_STEP = 3

function DrawCardOptUpDlg:ctor(...)
	self:initUI()
end

function DrawCardOptUpDlg:initUI(...)
	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
	self.modelControl = UIControls.Panel(self, "ModelControl")
	self.slotOfModelStageLoaded = Slot(self.onModelStageLoaded, self)
	self.slotOfSlideEnd = Slot(self.slideEnd, self)
	self.skipAllBtn = UIControls.Button(self, "BtnOver")

	self.skipAllBtn:setVisible(false)

	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/ChoukaModeStage", self.slotOfModelStageLoaded)

	self.modelStage:connectImage(self.modelViewport)

	self.needInAnim = true
end

function DrawCardOptUpDlg:onClose(...)
	GameSettings.resetShadowDistance("DrawCard")
	self.modelStage:resetShadow()
	DrawCardOptUpDlg.super.onClose(self)
end

function DrawCardOptUpDlg:onModelStageLoaded(modelStage)
	modelStage:initSlideOperation(self.modelControl, SLIDE_STEP, self.slotOfSlideEnd)
end

function DrawCardOptUpDlg:showDrawCardOperate(drawType, isSmall)
	self.drawType = drawType
	self.drawItems = CurAvatar.lastDrawGroupItems or {}

	local boxId = self:_getBoxId(isSmall)

	self.modelStage:setOperateModel(boxId, Functor(self._onBoxModelLoaded, self, isSmall))
end

function DrawCardOptUpDlg:_getBoxId(isSmall)
	if not isSmall then
		return 14
	else
		return 24
	end
end

function DrawCardOptUpDlg:_onBoxModelLoaded(isSmall)
	if self.needInAnim then
		self.modelStage:playIn()

		self.needInAnim = false
	else
		self:resetStage()
	end

	local maxStarLv = 4
	local hasHero = false

	for i, item in ipairs(self.drawItems) do
		if item:isHero() and item.star >= 5 then
			hasHero = true
			maxStarLv = 5

			break
		end
	end

	if isSmall then
		self.modelStage:setEffectColor(maxStarLv)
	elseif hasHero then
		self.modelStage:setFlyEffectActive({
			0,
			0,
			0,
			1,
			0
		})
	else
		self.modelStage:setFlyEffectActive({
			0,
			1,
			0,
			0,
			0
		})
	end

	self.modelStage:setOpenAudioPath(maxStarLv)
	self.modelStage:setBoxShadow(isSmall)
end

function DrawCardOptUpDlg:slideEnd()
	CurAvatar:sendNodeAnalyticsData(Const.OSS_TYPE_OPEN_BOX)

	if not self.showResultTimer then
		self.showResultTimer = Timer.New(Slot(self._showResult, self), DrawCardConfig.SHOW_LIGHT_RESULT)
	end

	self.showResultTimer:Restart()
end

function DrawCardOptUpDlg:_showResult(...)
	CurAvatar:showDrawUpResutlDlg()
	GameSettings.setShadowDistance(25, "DrawCard")
end

function DrawCardOptUpDlg:resetStage(...)
	self.modelStage:initSlideOperation(self.modelControl, SLIDE_STEP, self.slotOfSlideEnd)
	self.modelStage:directPlayInEnd()
	self.modelStage:resetShadow()
end

return DrawCardOptUpDlg
