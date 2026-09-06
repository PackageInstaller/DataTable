-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleLevelView.lua

module("logic.extensions.scuffle.view.ScuffleLevelView", package.seeall)

local ScuffleLevelView = class("ScuffleLevelView", TableViewComponent)

function ScuffleLevelView:ctor()
	ScuffleLevelView.super.ctor(self)
end

function ScuffleLevelView:buildUI()
	ScuffleLevelView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._roleModel = self:getGo("roleModel")
end

function ScuffleLevelView:bindEvents()
	ScuffleLevelView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function ScuffleLevelView:unbindEvents()
	ScuffleLevelView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function ScuffleLevelView:onEnter()
	ScuffleLevelView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SF_GetAllSeasonInfoRes, self._onGetAllSeasonInfoRes, self)
	self:_showRoleModel()
	self:_updateLevelList()
	ScuffleAgent.instance:sendSF_GetAllSeasonInfoReq()
end

function ScuffleLevelView:onExit()
	ScuffleLevelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SF_GetAllSeasonInfoRes, self._onGetAllSeasonInfoRes, self)
	self:_resetRoleModel()
end

function ScuffleLevelView:_onClickClose()
	self:close()
end

function ScuffleLevelView:_onGetAllSeasonInfoRes()
	self:_updateLevelList()
end

function ScuffleLevelView:_getPath()
	return {
		cellPath = "info/cell",
		viewPath = "info/tableview"
	}
end

function ScuffleLevelView:_updateCell(view, cell, data)
	local txtTitle = goutil.findChildTextComponent(cell, "title/txt")
	local levelIcon = goutil.findChild(cell, "levelIcon")
	local rankNode = goutil.findChild(cell, "main/rankNum")
	local txtRankNum = goutil.findChildTextComponent(cell, "main/rankNum/txtRank")
	local txtScore = goutil.findChildTextComponent(cell, "main/score/txtScore")
	local txtTotalCount = goutil.findChildTextComponent(cell, "main/totalCount/txtNumber")
	local txtWinNum = goutil.findChildTextComponent(cell, "main/winNum/txtWin")
	local txtWinRate = goutil.findChildTextComponent(cell, "main/winRate/txtWinRate")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	rankNode:SetActive(cell.index == 0)

	txtTitle.text = string.format("第%s届总览", GameUtil.getChineseNumber(data.seasonId))

	if data.rank > 0 then
		txtRankNum.text = data.rank or "未上榜"
	end

	txtScore.text = data.score
	txtTotalCount.text = data.total
	txtWinNum.text = data.wins
	txtWinRate.text = data.total == 0 and "0%" or string.format("%.1f%%", Mathf.Clamp01(data.wins / data.total) * 100)

	local cfg = ScuffleConfig.instance:getLevelCfgByScore(data.score)

	uGuiUtil.setSpriteToImage(levelIcon, uGuiUtil.SpriteType.BigBg, string.format(ScuffleModel.LevelPath, cfg.icon))

	txtName.text = cfg.levelName
end

function ScuffleLevelView:_clearTableview(cell)
	local levelIcon = Framework.ImageBigBG.GetFrom(cell.gameObject, "levelIcon")

	levelIcon:ClearImage()
end

function ScuffleLevelView:_showRoleModel()
	self:_resetRoleModel()

	local skinId = 10098
	local scale = 1

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, skinId, self._roleModel, scale, nil, nil)
end

function ScuffleLevelView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function ScuffleLevelView:_updateLevelList()
	local list = ScuffleModel.instance:getSeasonInfoList()

	GameUtil.reverse(list)
	self:updateListData(list)
end

return ScuffleLevelView
