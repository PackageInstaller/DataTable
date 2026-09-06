-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdZdlBuffPopView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdZdlBuffPopView", package.seeall)

local YouthArenaThirdZdlBuffPopView = class("YouthArenaThirdZdlBuffPopView", ViewComponent)
local TAB_DATA_LIST = {
	{
		tabName = "1v1",
		mode = YouthArenaThirdEnum.BattleMode.One
	},
	{
		tabName = "3v3",
		mode = YouthArenaThirdEnum.BattleMode.Three
	}
}

function YouthArenaThirdZdlBuffPopView:ctor()
	YouthArenaThirdZdlBuffPopView.super.ctor(self)
end

function YouthArenaThirdZdlBuffPopView:buildUI()
	YouthArenaThirdZdlBuffPopView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._btnSure = self:getGo("btnSure")
	self._tabScrollList = ScrollerList.create(self:getGo("tabScrView"), self:getGo("tabScrCell"), GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._buffScrollList = ScrollerList.create(self:getGo("buffCol/scrView"), self:getGo("buffCol/scrCell"), GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function YouthArenaThirdZdlBuffPopView:bindEvents()
	YouthArenaThirdZdlBuffPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function YouthArenaThirdZdlBuffPopView:unbindEvents()
	YouthArenaThirdZdlBuffPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function YouthArenaThirdZdlBuffPopView:onEnter()
	YouthArenaThirdZdlBuffPopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._roundId = checknumber(params[2])

	local defaultMode = checknumber(params[3])

	if not self:_isValidMode(self._curMode) then
		self._curMode = self:_isValidMode(defaultMode) and defaultMode or YouthArenaThirdEnum.BattleMode.One
	end

	self._txtTitle.text = "本轮加成"

	self:_refreshTabs()
	self:_refreshBuffs()
end

function YouthArenaThirdZdlBuffPopView:destroyUI()
	YouthArenaThirdZdlBuffPopView.super.destroyUI(self)

	if self._tabScrollList then
		self._tabScrollList:dispose()

		self._tabScrollList = nil
	end

	if self._buffScrollList then
		self._buffScrollList:dispose()

		self._buffScrollList = nil
	end

	self._activityId = nil
	self._roundId = nil
	self._curMode = nil
end

function YouthArenaThirdZdlBuffPopView:_isValidMode(mode)
	return mode == YouthArenaThirdEnum.BattleMode.One or mode == YouthArenaThirdEnum.BattleMode.Three
end

function YouthArenaThirdZdlBuffPopView:_refreshTabs()
	self._tabScrollList:reloadData(TAB_DATA_LIST)
end

function YouthArenaThirdZdlBuffPopView:_refreshBuffs()
	local list = YouthArenaThirdConfig.instance:getKnockoutBuffPlanDatasByRoundMode(self._activityId, self._roundId, self._curMode) or {}

	self._buffScrollList:reloadData(list)
end

function YouthArenaThirdZdlBuffPopView:_updateTabCell(view, cell, data)
	if not cell.gameObject then
		local go = cell
		local txtName = goutil.findChildTextComponent(go, "txtName")

		GameUtil.rmClickHandler(go)

		if txtName then
			if data then
				txtName.text = data.tabName or ""
			end
		end

		GameUtil.setUIGroupIdx(cell, data and data.mode == self._curMode and 1 or 0)
		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickTab, self, data))
	end
end

function YouthArenaThirdZdlBuffPopView:_clearTabCell(cell)
	GameUtil.rmClickHandler(cell.gameObject or cell)
end

function YouthArenaThirdZdlBuffPopView:_onClickTab(data)
	local mode = data and data.mode

	if not self:_isValidMode(mode) or mode == self._curMode then
		return
	end

	self._curMode = mode

	self:_refreshTabs()
	self:_refreshBuffs()
end

function YouthArenaThirdZdlBuffPopView:_updateBuffCell(view, cell, data)
	if not cell.gameObject then
		local go = cell
		local icon = goutil.findChild(go, "icon")
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local txtDesc = goutil.findChildTextComponent(go, "txtDesc")

		if data then
			txtName.text = data.name or ""
		end

		if data then
			txtDesc.text = data.desc or ""
		end

		if data and not string.nilorempty(data.icon) then
			uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, string.format("ui/%s.png", data.icon))
		else
			uGuiUtil.clearImage(icon)
		end
	end
end

function YouthArenaThirdZdlBuffPopView:_clearBuffCell(cell)
	if not cell.gameObject then
		local go = cell
		local icon = goutil.findChild(go, "icon")

		uGuiUtil.clearImage(icon)
	end
end

return YouthArenaThirdZdlBuffPopView
