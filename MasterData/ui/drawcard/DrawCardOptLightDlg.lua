-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawCardOptLightDlg.lua

local DrawCardConfig = require("DesignerScript/DrawCardConfig")
local DrawCardShowPanel = require("UI/DrawCard/DrawCardShowPanel")
local GameSettings = require("Helper/GameSettings")
local strClassName = "DrawCardOptLightDlg"
local DrawCardOptLightDlg = Class(strClassName, UIControls.Window)
local SLIDE_STEP = 3

function DrawCardOptLightDlg:ctor(...)
	self:initUI()
end

function DrawCardOptLightDlg:initUI(...)
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

function DrawCardOptLightDlg:onClose(...)
	GameSettings.resetShadowDistance("DrawCard")
	self.modelStage:resetShadow()
	DrawCardOptLightDlg.super.onClose(self)
end

function DrawCardOptLightDlg:onModelStageLoaded(modelStage)
	modelStage:initSlideOperation(self.modelControl, SLIDE_STEP, self.slotOfSlideEnd)
end

function DrawCardOptLightDlg:showDrawCardOperate(drawType, isSmall, groupId)
	self.drawType = drawType
	self.drawItems = CurAvatar.lastDrawGroupItems or {}

	self:_getPoolInfoCache()

	local boxId = self:_getBoxId(isSmall, groupId)

	self.modelStage:setOperateModel(boxId, Functor(self._onBoxModelLoaded, self, isSmall))
end

function DrawCardOptLightDlg:_getPoolInfoCache(...)
	if not CurAvatar then
		return
	end

	self.pooInfoCache = {
		drawNeedItemId = CurAvatar.drawNeedItemId,
		drawNeedItemNum = CurAvatar.drawNeedItemNum,
		drawPoolId = CurAvatar.drawPoolId,
		drawDroup = CurAvatar.drawDroup,
		drawOpActId = CurAvatar.drawOpActId
	}
end

function DrawCardOptLightDlg:_getBoxId(isSmall, groupId)
	if groupId == Const.DrawCampLightDark or groupId == Const.DrawNewBieCampLightDark then
		if not isSmall then
			return 14
		else
			return 24
		end
	end
end

function DrawCardOptLightDlg:_onBoxModelLoaded(isSmall)
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

function DrawCardOptLightDlg:slideEnd()
	CurAvatar:sendNodeAnalyticsData(Const.OSS_TYPE_OPEN_BOX)

	if not self.showResultTimer then
		self.showResultTimer = Timer.New(Slot(self._showResult, self), DrawCardConfig.SHOW_LIGHT_RESULT)
	end

	self.showResultTimer:Restart()
end

function DrawCardOptLightDlg:_showResult(...)
	CurAvatar:showDrawLightResutlDlg()
	GameSettings.setShadowDistance(25, "DrawCard")
end

function DrawCardOptLightDlg:resetStage(...)
	self.modelStage:initSlideOperation(self.modelControl, SLIDE_STEP, self.slotOfSlideEnd)
	self.modelStage:directPlayInEnd()
	self.modelStage:resetShadow()
end

return DrawCardOptLightDlg
