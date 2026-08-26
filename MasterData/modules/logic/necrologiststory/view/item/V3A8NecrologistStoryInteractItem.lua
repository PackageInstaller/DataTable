-- chunkname: @modules/logic/necrologiststory/view/item/V3A8NecrologistStoryInteractItem.lua

module("modules.logic.necrologiststory.view.item.V3A8NecrologistStoryInteractItem", package.seeall)

local V3A8NecrologistStoryInteractItem = class("V3A8NecrologistStoryInteractItem", NecrologistStoryBaseItem)

function V3A8NecrologistStoryInteractItem:onInit()
	self.simage = gohelper.findChildSingleImage(self.viewGO, "#simage_pic")
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_open")
	self.txtBtn = gohelper.findChildTextMesh(self.viewGO, "#btn_open/#txt_place")
	self.goProgress = gohelper.findChild(self.viewGO, "progress")
	self.imgFill = gohelper.findChildImage(self.goProgress, "#image_fill")
end

function V3A8NecrologistStoryInteractItem:onAddEvent()
	self.addClickCb(self, self.btnClick, self.onClickBtn, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.PlotChangePic, self.onPlotChangePic, self)
end

function V3A8NecrologistStoryInteractItem:onRemoveEvent()
	self:removeClickCb(self.btnClick)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.PlotChangePic, self.onPlotChangePic, self)
end

function V3A8NecrologistStoryInteractItem:onPlotChangePic(param)
	if param.storyId ~= self:getStoryId() then
		return
	end

	self:refreshPicture(param.picRes)
end

function V3A8NecrologistStoryInteractItem:onClickBtn()
	if self.isClicked then
		return
	end

	self.isClicked = true

	gohelper.setActive(self.btnClick, false)

	if self.leftTime and self.leftTime > 0 and self._tweenId then
		local mo = NecrologistStoryModel.instance:getCurStoryMO()

		if mo then
			mo:markSpecial(self:getStoryId())
		end

		gohelper.setActive(self.goProgress, false)
		self:killTweenId()
	end

	self:onPlayFinish(true)
end

function V3A8NecrologistStoryInteractItem:onPlayStory(isSkip)
	self.isClicked = false

	gohelper.setActive(self.btnClick, true)

	local storyConfig = self:getStoryConfig()
	local param = string.split(storyConfig.param, "#")

	self.leftTime = param[1] and tonumber(param[1]) or 0
	self.txtBtn.text = NecrologistStoryHelper.getDescByConfig(storyConfig)

	self:startCountDown()
	self:refreshPicture(param[2])
end

function V3A8NecrologistStoryInteractItem:refreshPicture(picRes)
	if string.nilorempty(picRes) then
		picRes = "rolestory_3020_gamepic_09_1"
	end

	self.simage:LoadImage(ResUrl.getNecrologistStoryPicBg(picRes), self.onSimageLoaded, self)
end

function V3A8NecrologistStoryInteractItem:onSimageLoaded()
	ZProj.UGUIHelper.SetImageSize(self.simage.gameObject)
end

function V3A8NecrologistStoryInteractItem:startCountDown()
	self:killTweenId()

	local hasCountDown = self.leftTime > 0

	gohelper.setActive(self.goProgress, hasCountDown)

	if self.leftTime <= 0 then
		return
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, self.leftTime, self._onFadeInUpdate, self._onFadeInFinish, self, nil, EaseType.Linear)
end

function V3A8NecrologistStoryInteractItem:_onFadeInUpdate(value)
	self.imgFill.fillAmount = value
end

function V3A8NecrologistStoryInteractItem:_onFadeInFinish()
	gohelper.setActive(self.goProgress, false)
	self:killTweenId()
	self:onClickBtn()
end

function V3A8NecrologistStoryInteractItem:killTweenId()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function V3A8NecrologistStoryInteractItem:caleHeight()
	return 400
end

function V3A8NecrologistStoryInteractItem:isDone()
	return self.isClicked
end

function V3A8NecrologistStoryInteractItem:onDestroy()
	self:killTweenId()
end

function V3A8NecrologistStoryInteractItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/v3a8_rolestoryinteractitem.prefab"
end

return V3A8NecrologistStoryInteractItem
