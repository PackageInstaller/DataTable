-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastRecipeInfoView.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastRecipeInfoView", package.seeall)

local PanTaoFeastRecipeInfoView = class("PanTaoFeastRecipeInfoView", ViewComponent)

function PanTaoFeastRecipeInfoView:ctor()
	PanTaoFeastRecipeInfoView.super.ctor(self)
end

function PanTaoFeastRecipeInfoView:unbindEvents()
	PanTaoFeastRecipeInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PanTaoFeastRecipeInfoView:bindEvents()
	PanTaoFeastRecipeInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PanTaoFeastRecipeInfoView:buildUI()
	PanTaoFeastRecipeInfoView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local goCell = self:getGo("tableview/tablecell")
	local goTab = self:getGo("tableview")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtName = self:getTxt("txtName")
	self._txtDesc = self:getTxt("txtDesc")
	self._showIcon = self:getGo("showIcon")
	self._txtToolTitle = self:getTxt("txtToolTitle")
	self._toolIcon = self:getGo("toolIcon")
end

function PanTaoFeastRecipeInfoView:onExit()
	PanTaoFeastRecipeInfoView.super.onExit(self)

	self._curElementId = 0

	self._tableView:dispose()
	uGuiUtil.clearImage(self._showIcon)
	uGuiUtil.clearImage(self._toolIcon)
end

function PanTaoFeastRecipeInfoView:onEnter()
	PanTaoFeastRecipeInfoView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = PanTaoFeastController.instance:getDefaultActivityId() or 0
	end

	self._curElementId = checknumber(params[2])

	self:_updateUIByCfg()

	local isVaild = self._recipeCfg ~= nil

	if not isVaild then
		TipsFacade.instance:openCommonTips(lang("传参数据异常"))
		self:close()

		return
	end

	self:_updateUIByInfo()
end

function PanTaoFeastRecipeInfoView:_updateUIByCfg()
	self._recipeCfg = PanTaoFeastConfig.instance:getRecipeCfgByDishId(self._activityId, self._curElementId)

	if self._recipeCfg then
		self._recipeMatList = self._recipeCfg.materialElementIds or {}
	end

	self._tableView:reloadData(self._recipeMatList)

	local elementNode = PanTaoFeastConfig.instance:getElementChainNodeByElementId(self._activityId, self._curElementId)
	local elementCfg = elementNode and elementNode.cfg

	if elementCfg then
		self._txtDesc.text = elementCfg.showDesc or ""
		self._txtName.text = elementCfg.name or ""

		local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, self._curElementId)

		if not GameUtil.isEmptyString(iconPath) then
			local spriteName = GameUrl.getItemIconUrl(iconPath)

			uGuiUtil.setSpriteToImage(self._showIcon, uGuiUtil.SpriteType.BigBg, spriteName)
		else
			uGuiUtil.clearImage(self._showIcon)
		end
	else
		self._txtName.text = ""
		self._txtDesc.text = ""
	end

	if self._recipeCfg then
		if not self._recipeCfg.cookToolId then
			local toolElementId = 0
			local toolCfg = PanTaoFeastConfig.instance:getStashCfg(self._activityId, toolElementId)

			if toolCfg then
				self._txtToolTitle.text = toolCfg.stashName or ""

				local iconPath = PanTaoFeastController.instance:getToolIconPathById(self._activityId, toolElementId)

				if not GameUtil.isEmptyString(iconPath) then
					local spriteName = GameUrl.getItemIconUrl(iconPath)

					uGuiUtil.setSpriteToImage(self._toolIcon, uGuiUtil.SpriteType.BigBg, spriteName)
				else
					uGuiUtil.clearImage(self._toolIcon)
				end
			else
				self._txtToolTitle.text = ""
			end
		end
	end
end

function PanTaoFeastRecipeInfoView:_updateUIByInfo()
	return
end

function PanTaoFeastRecipeInfoView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local elementId = checknumber(data)
	local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, elementId)

	uGuiUtil.clearImage(icon)

	if not GameUtil.isEmptyString(iconPath) then
		local spriteName = GameUrl.getItemIconUrl(iconPath)

		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spriteName)
	end

	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		UIStateManager.instance:push(ViewName.PanTaoFeastMatInfoView, self._activityId, elementId)
	end, self)
end

function PanTaoFeastRecipeInfoView:_clearCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)

	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

return PanTaoFeastRecipeInfoView
