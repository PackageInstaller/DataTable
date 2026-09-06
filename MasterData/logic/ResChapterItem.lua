-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/ResChapterItem.lua

module("logic.extensions.plotcopy.view.ResChapterItem", package.seeall)

local ResChapterItem = class("ResChapterItem")
local LuaComponentContainer = Framework.LuaComponentContainer

function ResChapterItem.AddOnce(go)
	local component = LuaComponentContainer.Get(go, ResChapterItem)

	component = component or LuaComponentContainer.Add(go, ResChapterItem)

	return component
end

function ResChapterItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._imgBgLock = goutil.findChild(go, "main/imgLocked")
	self._imgBg = goutil.findChild(go, "main/imgBg"):GetComponent(goutil.Type_UIImage)
	self._btnClick = Framework.ButtonAdapter.GetFrom(go, "main")
	self._imgBgColorChange = goutil.findChild(go, "main/imgBg"):GetComponent("UIImageColorChange")
	self._double = goutil.findChild(go, "main/double")
	self._redPoint = goutil.findChild(go, "main/redPoint")
	self._doubleLeftTimeBg = goutil.findChild(go, "main/double/img")
	self._txtDoubleLeftTime = goutil.findChildTextComponent(go, "main/double/txtDoubleLeftTime")
	self._free = goutil.findChild(go, "main/free")
	self._tip = goutil.findChild(go, "main/tip")
	self._tip2 = goutil.findChild(go, "main/tip2")
end

function ResChapterItem:init(index, data, view)
	self._index = index
	self._data = data
	self._view = view

	self._btnClick:AddClickListener(self._onBtnClick, self)
	self._imgBgLock:SetActive(data.isLock)
	self._imgBgColorChange:SetState(data.isLock and 0 or 1)
	uGuiUtil.setSpriteToImage(self._imgBg.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCopyChapterBgUrl(data.cfg.chapterPic))

	local val = data.isLock and 0.5 or 1

	Game.ImageUtil.SetColorRGBA(self._imgBg, val, val, val, 1)

	local isShowDouble = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.Material, data.cfg.chapterId)

	self._double:SetActive(isShowDouble)
	goutil.setActive(self._redPoint, MaterialChallengeController.instance:isRedPointActive(data.cfg.chapterId))

	self._txtDoubleLeftTime.text = MaterialChallengeModel.instance:getMaterialDoubleTimesDesc(data.cfg.chapterId)

	goutil.setActive(self._doubleLeftTimeBg, false)
	goutil.setActive(self._txtDoubleLeftTime.gameObject, false)
	self:_initTip()
	self:_initTip2()
end

function ResChapterItem:reset()
	self._data = nil
	self._view = nil

	self._btnClick:RemoveClickListener()
end

function ResChapterItem:_onBtnClick()
	if self._data.isLock then
		local cfgStage = MaterialChallengeConfig.instance:getStageById(self._data.cfg.chapterId, 1)
		local unlockId = cfgStage.unlockId
		local cfgFuncOpen = FuncOpenConfig.instance:getFunctionOpenById(unlockId)

		if cfgFuncOpen then
			FloatWordMgr.instance:show(cfgFuncOpen.description)
		end

		return
	end

	local isNotShow = true

	GameUtil.saveUserDayData("ResChapterItem" .. self._data.cfg.chapterId, isNotShow)
	MaterialChallengeController.instance:openChapterView(self._data.cfg.chapterId)
end

function ResChapterItem:_initTip()
	local startTime = "2022-07-08 05:00:00"
	local endTime = "2022-07-15 05:00:00"
	local curTime = ServerTime.now()

	goutil.setActive(self._tip, GameUtil.checkIsInTimePeriod(startTime, endTime))
end

function ResChapterItem:_initTip2()
	local startTime = "2022-07-29 05:00:00"
	local endTime = "2022-08-05 05:00:00"
	local curTime = ServerTime.now()
	local isTargetChapterId = self._data.cfg.chapterId == StarGodChallengeModel.instance:getChapterId()

	goutil.setActive(self._tip2, isTargetChapterId and GameUtil.checkIsInTimePeriod(startTime, endTime))
end

return ResChapterItem
