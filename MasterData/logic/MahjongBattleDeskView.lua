-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleDeskView.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleDeskView", package.seeall)

local MahjongBattleDeskView = class("MahjongBattleDeskView", ViewComponent)

function MahjongBattleDeskView:ctor()
	MahjongBattleDeskView.super.ctor(self)
end

function MahjongBattleDeskView:unbindEvents()
	MahjongBattleDeskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MahjongBattleDeskView:bindEvents()
	MahjongBattleDeskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function MahjongBattleDeskView:buildUI()
	MahjongBattleDeskView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._cardcell = self:getGo("cardcell")

	local goCell = self:getGo("tablecell")
	local goTab = self:getGo("tableview")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	goutil.setActive(self._cardcell, false)
end

function MahjongBattleDeskView:onExit()
	MahjongBattleDeskView.super.onExit(self)
	self._tableView:dispose()
end

function MahjongBattleDeskView:onEnter()
	MahjongBattleDeskView.super.onEnter(self)

	self._subTableViewDic = {}
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 571001
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
end

function MahjongBattleDeskView:_updateUIByCfg()
	if not self._curShowCfgMaps then
		self._curShowCfgMaps = {}

		local mjCfgs = MahjongBattleConfig.instance:getMahjongCfgs(self._activityId) or {}

		for _, cfg in ipairs(mjCfgs) do
			if not self._curShowCfgMaps[cfg.type] then
				table.insert(self._curShowCfgMaps[cfg.type], cfg)

				self._curShowCfgMaps[cfg.type] = self._curShowCfgMaps[cfg.type]
			end
		end
	end
end

function MahjongBattleDeskView:_updateUIByInfo()
	self._curShowNumMap = {}

	local challengeInfo = MahjongBattleModel.instance:getCurChallengeInfoByActId(self._activityId)

	if challengeInfo then
		if not challengeInfo.mahjongPoolIdToNumMap then
			for _, mjInfo in ipairs(challengeInfo.mahjongPoolIdToNumMap) do
				self._curShowNumMap[mjInfo.left] = mjInfo.right or 0
			end
		end
	end

	self._tableView:reloadData(self._curShowCfgMaps or {})
end

function MahjongBattleDeskView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local goSubTableview = goutil.findChild(go, "subTableview")

	if not goSubTableview or not self._cardcell then
		return
	end

	if not self._subTableViewDic[goSubTableview] then
		local subTableview = ScrollerList.create(goSubTableview, self._cardcell, GameUtil.handler(self._updateSubCell, self), GameUtil.handler(self._clearSubCell, self))

		self._subTableViewDic[goSubTableview] = subTableview

		local cfgList = data or {}

		subTableview:reloadData(cfgList)
		subTableview:dragNotifyParent()
	end
end

function MahjongBattleDeskView:_clearCell(cell)
	local go = cell.gameObject
	local goSubTableview = goutil.findChild(go, "subTableview")

	if goSubTableview then
		local subTableview = self._subTableViewDic[goSubTableview]

		if subTableview then
			subTableview:dispose()

			self._subTableViewDic[goSubTableview] = nil
		end
	end
end

function MahjongBattleDeskView:_updateSubCell(view, cell, data)
	local go = cell.gameObject
	local txtNum = goutil.findChildTextComponent(go, "card/txtNum")
	local picChanger = goutil.findChildComponent(go, "card/showpic", "UIImageSpriteChange")

	txtNum.text = self._curShowNumMap[data.mahjongId] or 0

	if not data.showPic then
		local showPic = ""

		if showPic ~= "" and picChanger then
			picChanger:ChangeSprite(showPic)
		end
	end
end

function MahjongBattleDeskView:_clearSubCell(cell)
	return
end

return MahjongBattleDeskView
