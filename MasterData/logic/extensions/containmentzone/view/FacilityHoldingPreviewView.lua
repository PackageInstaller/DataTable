-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingPreviewView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingPreviewView", package.seeall)

local M = class("FacilityHoldingPreviewView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._btnClose = self:getBtn("facility_holding_preview_view_-974805274")
	self._imgIconBg = self:getBigBg("facility_holding_preview_view_-228128873")
	self._imgIconSmall = self:getImage("facility_holding_preview_view_-1144086076")
	self._imgDegree = self:getImage("facility_holding_preview_view_-166269154")
	self._txtMark = self:getText("facility_holding_preview_view_-1978856243")
	self._txtName = self:getText("facility_holding_preview_view_-2069731507")
	self._goPrototypeGroup = self:getGo("facility_holding_preview_view_-1165655475")
	self._goPrototypeItem = self:getGo("facility_holding_preview_view_511383133")
	self._goTypUnlockTitle = self:getGo("facility_holding_preview_view_-1764115630")
	self._goTypPreviewTitle = self:getGo("facility_holding_preview_view_-1113833613")
end

function M:destroyUI()
	self._guiAnimation = nil
	self._btnClose = nil
	self._imgIconBg = nil
	self._imgIconSmall = nil
	self._imgDegree = nil
	self._txtMark = nil
	self._txtName = nil
	self._goPrototypeGroup = nil
	self._goPrototypeItem = nil
	self._goTypUnlockTitle = nil
	self._goTypPreviewTitle = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)

	local info = self:getFirstParam()
	local typ = info.typ or 2

	self:setTyp(typ)

	local protomerId = info.protomerId

	self:setIcon(protomerId)
	self:setDegreeImg(protomerId)

	local prototypeTable = ContainmentConfig.instance:getProtomerPrototypeCoLstByProtomerId(protomerId)

	self:_updatePrototype(prototypeTable)

	local cfgBackPack = ContainmentConfig.instance:getProtomerBackpackCfg(protomerId)

	if cfgBackPack == nil then
		printError("无法找到原体背包配置,原体id", protomerId)
	end

	self._txtName.text = string.format("%s" .. lang("tip_image_data"), cfgBackPack and cfgBackPack.name or lang("tip_image_data"))

	local cfgInfo = ContainmentConfig.instance:getProtomerInfoById(protomerId)

	if cfgInfo then
		self._txtMark.text = string.format("%s-%s", cfgInfo.serialdegree, cfgInfo.serialnum)
	else
		printError("无法找到原体信息配置,原体id", protomerId)

		self._txtMark.text = ""
	end

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")
end

function M:onExitFinished()
	self._imgIconBg:ClearImage()
end

function M:_onClickClose()
	self:close()
end

function M:setTyp(typ)
	goutil.setActive(self._goTypUnlockTitle, typ == 1)
	goutil.setActive(self._goTypPreviewTitle, typ == 2)
end

function M:setIcon(protomerId)
	ContainmentUtil.setProtomerDynIcon(self._imgIconSmall, protomerId)
	ContainmentUtil.setProtomerBigBgPreview(self._imgIconBg, protomerId)
end

function M:setDegreeImg(protomerId)
	local cfg = ContainmentConfig.instance:getProtomerDegreeCoByProtomerId(protomerId)

	if cfg then
		IconLoader.setSprite(self._imgDegree, IconType.DynSpriteAtlas_Room, cfg.icon)
	end
end

function M:_updatePrototype(tablePrototypeLst)
	local count = #tablePrototypeLst

	while count > self._goPrototypeGroup.transform.childCount do
		goutil.cloneAndSetParent(self._goPrototypeItem, self._goPrototypeGroup.transform)
	end

	for i = 0, self._goPrototypeGroup.transform.childCount - 1 do
		local tmpGo = self._goPrototypeGroup.transform:GetChild(i).gameObject
		local show = i < #tablePrototypeLst

		if show then
			local prototypeIconUrl = tablePrototypeLst[i + 1].icon
			local prototypeName = tablePrototypeLst[i + 1].name
			local imgIcon = goutil.findChildImageComponent(tmpGo, "Image (4)")
			local txtIcon = goutil.findChildTextComponent(tmpGo, "Text1 (1)")

			IconLoader.setSprite(imgIcon, IconType.DynSpriteAtlas_Room, prototypeIconUrl)

			txtIcon.text = prototypeName
		end

		goutil.setActive(tmpGo, show)
	end
end

return M
