-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021lookbackzongjieView.lua

module("logic.extensions.recap2021.view.Recap2021lookbackzongjieView", package.seeall)

local Recap2021lookbackzongjieView = class("Recap2021lookbackzongjieView", ViewComponent)

function Recap2021lookbackzongjieView:ctor()
	Recap2021lookbackzongjieView.super.ctor(self)
end

function Recap2021lookbackzongjieView:unbindEvents()
	Recap2021lookbackzongjieView.super.unbindEvents(self)
	self._btnShare:RemoveClickListener()
	self._btnRefreshRandom:RemoveClickListener()
end

function Recap2021lookbackzongjieView:bindEvents()
	Recap2021lookbackzongjieView.super.bindEvents(self)
	self._btnShare:AddClickListener(self._onClickbtnShare, self)
	self._btnRefreshRandom:AddClickListener(self._onClickbtnRefreshRandom, self)
end

function Recap2021lookbackzongjieView:buildUI()
	Recap2021lookbackzongjieView.super.buildUI(self)

	self._btnShare = self:getBtn("btnShare")
	self._btnRefreshRandom = self:getBtn("btnRefreshRandom")
	self._txtRandom1 = goutil.findChildTextComponent(self.mainGO, "txtRandom1")
	self._txtRandom2 = goutil.findChildTextComponent(self.mainGO, "txtRandom2")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txt1 = goutil.findChildTextComponent(self.mainGO, "root/desc1/txt1")
	self._txt2 = goutil.findChildTextComponent(self.mainGO, "root/desc2/txt1")
	self._txt3 = goutil.findChildTextComponent(self.mainGO, "root/desc3/txt1")
	self._txt4 = goutil.findChildTextComponent(self.mainGO, "root/desc4/txt1")
	self._txt5 = goutil.findChildTextComponent(self.mainGO, "root/desc5/txt1")
	self._txtNum1 = goutil.findChildTextComponent(self.mainGO, "root/desc1/txt2")
	self._txtNum2 = goutil.findChildTextComponent(self.mainGO, "root/desc2/txt2")
	self._txtNum3 = goutil.findChildTextComponent(self.mainGO, "root/desc3/txt2")
	self._txtNum4 = goutil.findChildTextComponent(self.mainGO, "root/desc4/txt2")
	self._txtNum5 = goutil.findChildTextComponent(self.mainGO, "root/desc5/txt2")
	self._txtTag2 = goutil.findChildTextComponent(self.mainGO, "tag1/txt")
	self._txtTag3 = goutil.findChildTextComponent(self.mainGO, "tag2/txt")
	self._txtTag1 = goutil.findChildTextComponent(self.mainGO, "tag3/txt")
	self._sharerootGo = self:getGo("shareroot")
	self._itemconGo = self:getGo("shareroot/con")
	self._roleChange = self:getGo("rolecon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._descGo1 = self:getGo("root/desc1")
	self._descGo2 = self:getGo("root/desc2")
	self._descGo3 = self:getGo("root/desc3")
	self._descGo4 = self:getGo("root/desc4")
	self._descGo5 = self:getGo("root/desc5")
end

function Recap2021lookbackzongjieView:onExit()
	Recap2021lookbackzongjieView.super.onExit(self)
	GlobalDispatcher:removeListener(Recap2021Controller.UpdateShareData, self._UpdateShareData, self)
	MaterialMgr.resetAll(self._itemconGo)
	removetimer(self._updateItemsPos, self)
end

function Recap2021lookbackzongjieView:onEnter()
	Recap2021lookbackzongjieView.super.onEnter(self)
	GlobalDispatcher:addListener(Recap2021Controller.UpdateShareData, self._UpdateShareData, self)

	local params = self:getOpenParam()

	self._personLookbackMo = params[1]
	self._viewRef = params[2]
	self._randomWords = Recap2021Config.instance:getPersonRandomWords()

	self:_perMoveItmes()
	self:_updatePart1()
	self:_setStaticTag()
	self:_setRandomTag()
	self:_setShareRewardState()

	self._txtTitle.text = self._personLookbackMo.viewCfg.name

	self._roleChange:SetState(RoleModel.instance:getGender())
	SurveyController.instance:reportBehavior(SurveyBehaviorID.READ_PERSON_RECAP2021)
end

function Recap2021lookbackzongjieView:_onClickbtnShare()
	ShareController.instance:share(10, {
		self._btnShare.gameObject,
		self._viewRef._txtTitle.gameObject,
		self._viewRef._btnClose.gameObject,
		self._sharerootGo
	})
	SurveyController.instance:reportBehavior(SurveyBehaviorID.SHARE_PERSON_RECAP2021)
end

function Recap2021lookbackzongjieView:_onClickbtnRefreshRandom()
	self:_setRandomTag()
end

function Recap2021lookbackzongjieView:_updatePart1()
	local cfgs = self._personLookbackMo:getCfgs()

	for i, v in ipairs(cfgs) do
		local value = Recap2021Model.instance:getDescByDataId(v.dataId)
		local noData = not not (Recap2021Model.instance:isNumberValueByDataId(v.dataId) and checknumber(value) < 0)

		if (type(value) == "number" and value <= 0 or nil) and true then
			self["_txt" .. i].text = v.noDataDesc
			self["_txtNum" .. i].text = ""
		else
			self["_txt" .. i].text = v.desc
			self["_txtNum" .. i].text = value
		end

		local go = self["_descGo" .. i]
		local canvasGroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))

		canvasGroup.alpha = 0

		local transform = go.transform
		local startPosX = self._moveDistance + (i - 1) * 80
		local x, y = Framework.TransformUtil.GetAnchoredPos(transform, 0, 0)

		Framework.TransformUtil.SetAnchoredPos(transform, startPosX, y)

		self._needMoveItems[go] = {
			currPosX = 0,
			isFinish = false,
			endPosX = 0,
			runTime = 0,
			transform = transform,
			canvasGroup = canvasGroup,
			startTime = self._duration * 0.8 * (i - 1),
			startPosX = startPosX,
			posY = y
		}
	end
end

function Recap2021lookbackzongjieView:_setStaticTag()
	self._txtTag1.text = Recap2021Model.instance:getCacheTag(1)
	self._txtTag2.text = Recap2021Model.instance:getCacheTag(2)
	self._txtTag3.text = Recap2021Model.instance:getCacheTag(3)
end

function Recap2021lookbackzongjieView:_setRandomTag()
	local newWords = table.values(self._randomWords)
	local len = #newWords
	local num = math.random(1, len)
	local word1 = table.remove(newWords, num)
	local words = string.split(word1.desc, "\n")

	self._txtRandom1.text = words[1] or ""
	self._txtRandom2.text = words[2] or ""
end

function Recap2021lookbackzongjieView:_UpdateShareData()
	self:_setShareRewardState()
end

function Recap2021lookbackzongjieView:_setShareRewardState()
	local canGainPrize = Recap2021Model.instance:checkPersonEventPrizeRed()

	if canGainPrize then
		MaterialMgr.resetAll(self._itemconGo)

		local cfg = ShareConfig.instance:getShareById(10)

		MaterialMgr.setCellByCfg(cfg.prize, self._itemconGo)
	end

	goutil.setActive(self._sharerootGo, canGainPrize)
end

function Recap2021lookbackzongjieView:_perMoveItmes()
	self._moveDistance = 300
	self._needMoveItems = {}
	self._runTime = 0
	self._duration = 0.3

	settimer(0, self._updateItemsPos, self, true)
end

function Recap2021lookbackzongjieView:_updateItemsPos()
	self._runTime = self._runTime + Time.deltaTime

	local isMove = false

	for k, v in pairs(self._needMoveItems) do
		if not v.isFinish then
			isMove = true

			if self._runTime >= v.startTime then
				if v.runTime < self._duration then
					local percent = v.runTime / self._duration

					v.runTime = v.runTime + Time.deltaTime
					v.canvasGroup.alpha = percent
					v.currPosX = v.startPosX - (v.startPosX - v.endPosX) * percent
				else
					v.currPosX = v.endPosX
					v.canvasGroup.alpha = 1
					v.isFinish = true
				end

				Framework.TransformUtil.SetAnchoredPos(v.transform, v.currPosX, v.posY)
			end
		end
	end

	if not isMove then
		removetimer(self._updateItemsPos, self)
	end
end

return Recap2021lookbackzongjieView
