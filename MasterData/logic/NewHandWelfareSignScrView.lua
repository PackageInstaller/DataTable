-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewHandWelfareSignScrView.lua

module("logic.extensions.newhandwelfare.view.NewHandWelfareSignScrView", package.seeall)

local NewHandWelfareSignScrView = class("NewHandWelfareSignScrView", ViewComponent)

function NewHandWelfareSignScrView:buildUI()
	NewHandWelfareSignScrView.super.buildUI(self)

	self._prizeScrView = self:getGo("prizeCol/scrView")
	self._prizeViewport = self:getGo("prizeCol/scrView/doubleScrollViewport")

	local prizeScrCell1 = self:getGo("prizeCol/scrCell1")
	local prizeScrCell2 = self:getGo("prizeCol/scrCell2")
	local prizeScrCell3 = self:getGo("prizeCol/scrCell3")

	self._sizeList = {}

	local prizeScrCells = {
		prizeScrCell1,
		prizeScrCell2,
		prizeScrCell3
	}

	for tag, go in ipairs(prizeScrCells) do
		self._sizeList[tag] = {
			GameUtil.getWidth(go),
			GameUtil.getHeight(go)
		}
	end

	self._prizeScrollerList = ScrollerList.create(self._prizeScrView, prizeScrCells, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeScrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._prizeScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))

	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._txtLeftTime = self:getTxt("leftTime/txt")
end

function NewHandWelfareSignScrView:bindEvents()
	NewHandWelfareSignScrView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
end

function NewHandWelfareSignScrView:unbindEvents()
	NewHandWelfareSignScrView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
end

function NewHandWelfareSignScrView:onEnter()
	NewHandWelfareSignScrView.super.onEnter(self)

	self._prizeCfg = self._prizeCfg or {}

	self.addGEvent(self, NewhandwelfareController.NewHandWelfareGetInfoRes, self._onUpdateUI, self)
	self.addGEvent(self, NewhandwelfareController.NewHandWelfareGainSignInPrizeRes, self._onUpdateUI, self)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())

	self:_onUpdateUI()
end

function NewHandWelfareSignScrView:onExit()
	NewHandWelfareSignScrView.super.onExit(self)
	removetimer(self._onTicking, self)
	self._prizeScrollerList:dispose()
end

function NewHandWelfareSignScrView:_updateTime()
	self._endTime = NewhandwelfareModel.instance:getNewHandPlayerEndTime()

	settimer(1, self._onTicking, self, true)
	self:_onTicking()
end

function NewHandWelfareSignScrView:_onTicking()
	local leftTime = Mathf.Max(self._endTime - ServerTime.now(), 0)

	self._txtLeftTime.text = GameUtil.FormatTimeWordsNoSec(leftTime)

	if leftTime <= 0 then
		leftTime = 0

		removetimer(self._onTicking, self)
	end
end

function NewHandWelfareSignScrView:_onUpdateUI()
	self._periodId = NewhandwelfareModel.instance:getPeriodId()
	self._prizeCfg = NewhandwelfareConfig.instance:getSignInRewardCfgs(self._periodId) or {}

	self._prizeScrollerList:reloadData(self._prizeCfg)
	self:_updateTime()
end

function NewHandWelfareSignScrView:_updatePrizeCell(view, cell, data, tag)
	local day = data.day
	local isReceive = NewhandwelfareModel.instance:isGainSignInPrize(day)
	local isCanGain = NewhandwelfareModel.instance:checkCanGainSingInPrize(self._periodId, day)
	local mainGo = cell.gameObject
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local bg = goutil.findChild(mainGo, "bg")
	local txtDay = goutil.findChildTextComponent(mainGo, "bg/txtDay")
	local txtLock = goutil.findChildTextComponent(mainGo, "txtLock")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")
	local itemScrCell = goutil.findChild(mainGo, "itemScrCell")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	txtDay.text = day

	GameUtil.SetActive(receivedGo, isReceive)
	GameUtil.SetActive(txtLock.gameObject, not isReceive and not isCanGain)
	GameUtil.setUIGroupIdx(mainGo, isReceive and 1 or 0)
	GameUtil.SetGray(bg, isReceive)
	GameUtil.SetActive(redPoint, isCanGain)
	GameUtil.SetActive(btnGet, isCanGain)

	if isCanGain then
		local effPath = "fx_ui_qirirenwu/fx_ui_kelingqu_ceshihuikui.prefab"

		self:playViewEffectUniGo(effPath, effectRoot, self._prizeViewport, true)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	if itemScrView and itemScrCell then
		local prizeStrArr = string.split(data.prize, "#")

		self._itemScrollerListDic = self._itemScrollerListDic or {}
		self._itemScrollerListDic[mainGo] = self._itemScrollerListDic[mainGo] or ScrollerList.create(itemScrView, itemScrCell, GameUtil.handler(self._updateItemCell, self, isCanGain), GameUtil.handler(self._clearItemCell, self))

		local scrollerList = self._itemScrollerListDic[mainGo]

		scrollerList:setCenterMode(true)
		scrollerList:reloadData(prizeStrArr)
	end

	GameUtil.addClickHandler(btnGet, function()
		if not isCanGain then
			return
		end

		NewHandWelfareAgent.instance:sendNewHandWelfareGainSignInPrizeReq(day)
	end)
end

function NewHandWelfareSignScrView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	self:stopViewEffectUniGo(effectRoot)
	GameUtil.rmClickHandler(btnGet)

	if self._itemScrollerListDic then
		if self._itemScrollerListDic then
			self._itemScrollerListDic:dispose()

			self._itemScrollerListDic[mainGo] = nil
		end
	end
end

function NewHandWelfareSignScrView:_updateItemCell(isCanGain, view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")
	local proxy = MaterialMgr.setCellByCfg(prizeStr, item)

	if proxy then
		proxy.binder:setEffStatus(false)
	end
end

function NewHandWelfareSignScrView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function NewHandWelfareSignScrView:_getTagByIdx(data, idx)
	local tag = Mathf.Clamp(data.tag, 1, #self._sizeList)

	if tag ~= data.tag then
		printError(string.format("配置tag错误，请检查配置，配了%s, 应该取值(%s ~ %s),periodId:%s", data.tag, 1, #self._sizeList, self._periodId))
	end

	return tag
end

function NewHandWelfareSignScrView:_getCellSize(view, idx)
	local data = self._prizeCfg[idx + 1]
	local tag = self:_getTagByIdx(data, idx)

	return self._sizeList[tag][1], self._sizeList[tag][2]
end

function NewHandWelfareSignScrView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function NewHandWelfareSignScrView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function NewHandWelfareSignScrView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function NewHandWelfareSignScrView:_getSkinId()
	return 11010
end

return NewHandWelfareSignScrView
