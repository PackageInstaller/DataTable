-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiumumchallenge/view/XiuMumLevelView.lua

module("logic.extensions.xiumumchallenge.view.XiuMumLevelView", package.seeall)

local XiuMumLevelView = class("XiuMumLevelView", ViewComponent)

function XiuMumLevelView:buildUI()
	XiuMumLevelView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goCell = self:getGo("levelCell")
	self._goTableview = self:getGo("levelView")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function XiuMumLevelView:bindEvents()
	XiuMumLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function XiuMumLevelView:unbindEvents()
	XiuMumLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function XiuMumLevelView:onEnter()
	XiuMumLevelView.super.onEnter(self)

	self._stageCfgs = XiuMumChallengeModel.instance:getCurLevelCfgs()

	self._tableview:reloadData(self._stageCfgs or {})
	self._tableview:MoveCellToBegin(XiuMumChallengeModel.instance:getCurPassStageId())
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.close, self)
end

function XiuMumLevelView:onExit()
	XiuMumLevelView.super.onExit(self)
	self._tableview:dispose()
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self.close, self)
end

function XiuMumLevelView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	GameUtil.addClickHandler(cell.btnChallenge, GameUtil.handler(self._onClickChallenge, self, data))

	cell.txtLevelNum.text = data.stageId
	cell.txtDesc.text = data.desc
	cell.txtLevelName.text = data.stageName

	MaterialMgr.setCellByCfg(data.prize, cell.iconReward)

	local modelCo = CharacterConfig.instance:getModelCo(data.showSkinId)

	if modelCo then
		uGuiUtil.setSpriteToImage(cell.petCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	end

	local curStageId = XiuMumChallengeModel.instance:getCurPassStageId() + 1

	if curStageId < data.stageId then
		GameUtil.SetGray(cell.go, true)
	elseif data.stageId == curStageId then
		-- block empty
	else
		goutil.setActive(cell.pass, true)
	end
end

function XiuMumLevelView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.petCon = goutil.findChild(cell.go, "pet/con")
	cell.txtLevelNum = goutil.findChildTextComponent(cell.go, "levelNum/txt")
	cell.txtLevelName = goutil.findChildTextComponent(cell.go, "levelName/txtName")
	cell.iconReward = goutil.findChild(cell.go, "reward/icon")
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")
	cell.pass = goutil.findChild(cell.go, "pass")
	cell.btnChallenge = goutil.findChild(cell.go, "btnChallenge")

	GameUtil.rmClickHandler(cell.btnChallenge)
	uGuiUtil.clearImage(cell.petCon)
	MaterialMgr.resetAll(cell.iconReward)
	goutil.setActive(cell.pass, false)
	GameUtil.SetGray(cell.go, false)

	return cell
end

function XiuMumLevelView:_onClickChallenge(data)
	if data then
		local curStageId = XiuMumChallengeModel.instance:getCurPassStageId() + 1

		if curStageId < data.stageId then
			FloatWordMgr.instance:show(langPara("请先通关第%s关", curStageId))
		elseif data.stageId == curStageId then
			if ServerTime.now() > GameUtil.string2time(data.startTime) then
				ViewAutoShowController.instance:saveCurModalView()
				UIStateManager.instance:push(self:_getGameView())
			else
				FloatWordMgr.instance:show(langPara("关卡将于%s后开放", data.startTime))
			end
		else
			FloatWordMgr.instance:show(lang("已通关当前关卡"))
		end
	end
end

function XiuMumLevelView:_getGameView()
	return ViewName.XiuMumGameView
end

return XiuMumLevelView
