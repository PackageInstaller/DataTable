-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/view/HolyDragonTemplePassPopWin.lua

module("logic.extensions.holydragontemple.view.HolyDragonTemplePassPopWin", package.seeall)

local HolyDragonTemplePassPopWin = class("HolyDragonTemplePassPopWin", ViewComponent)

function HolyDragonTemplePassPopWin:buildUI()
	HolyDragonTemplePassPopWin.super.buildUI(self)

	self._txtName = self:getTxt("txtName")
	self._txtBuffName = self:getTxt("buffName/txt")
	self._buffIcon = self:getGo("buffIcon")
	self._btnSure = self:getGo("btnSure")
end

function HolyDragonTemplePassPopWin:bindEvents()
	HolyDragonTemplePassPopWin.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function HolyDragonTemplePassPopWin:unbindEvents()
	HolyDragonTemplePassPopWin.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function HolyDragonTemplePassPopWin:onEnter()
	HolyDragonTemplePassPopWin.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._templeActivityId = checknumber(params[1])
	self._floorId = checknumber(params[2])
	self._fieldActivityId = checknumber(params[3])
	self._fieldId = checknumber(params[4])

	if self._fieldActivityId <= 0 then
		self._fieldActivityId = HolyDragonFieldController.instance:getActivityId()
	end

	self:_onUpdate()
end

function HolyDragonTemplePassPopWin:onExit()
	HolyDragonTemplePassPopWin.super.onExit(self)
	self:_clearBuffIcon()
end

function HolyDragonTemplePassPopWin:_onUpdate()
	local floorData = HolyDragonTempleConfig.instance:getFloorData(self._templeActivityId, self._floorId)

	if self._fieldId <= 0 and floorData then
		self._fieldId = checknumber(floorData.relevantFieldId)
	end

	local var_6_0 = self._txtName

	if floorData then
		var_6_0.text = langPara("已通关%s", floorData.name or "") or lang("已通关圣殿")
	end

	self._buffData = HolyDragonFieldConfig.instance:getBuffData(self._fieldActivityId, self._fieldId, 1)
	self._txtBuffName.text = self._buffData.name

	self:_updateBuffIcon()
end

function HolyDragonTemplePassPopWin:_updateBuffIcon()
	self:_clearBuffIcon()

	if self._buffData then
		if not self._buffData.icon then
			local icon

			if not string.nilorempty(icon) then
				uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, self:_getBuffIconUrl(icon))
			end
		end
	end
end

function HolyDragonTemplePassPopWin:_getBuffIconUrl(icon)
	local iconUrl = icon

	if string.sub(iconUrl, 1, 3) ~= "ui/" then
		iconUrl = "ui/" .. iconUrl
	end

	return iconUrl .. ".png"
end

function HolyDragonTemplePassPopWin:_clearBuffIcon()
	uGuiUtil.clearImage(self._buffIcon)
end

function HolyDragonTemplePassPopWin:_onClickBtnSure()
	self:close()

	if self._fieldActivityId > 0 and self._fieldId > 0 then
		UIStateManager.instance:push(ViewName.HolyDragonFieldBuffView, self._fieldActivityId, self._fieldId)
	end
end

return HolyDragonTemplePassPopWin
