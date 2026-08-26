-- chunkname: @modules/logic/gm/view/GM_ArcadeView.lua

module("modules.logic.gm.view.GM_ArcadeView", package.seeall)

local GM_ArcadeView = class("GM_ArcadeView", BaseView)

function GM_ArcadeView:onInitView()
	self._inputitem11 = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item1/#input_item1_1")
	self._inputitem12 = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item1/#input_item1_2")
	self._inputitem13 = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item1/#input_item1_3")
	self._btnitem1 = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item1/#btn_item1")
	self._inputitem31 = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item3/#input_item3_1")
	self._btnitem3 = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item3/#btn_item3")
	self._btnitem5 = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item5/#btn_item5")
	self._btnitem2 = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item2/#btn_item2")
	self._btnitem4 = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item4/#btn_item4")
	self._dropitem51 = gohelper.findChildDropdown(self.viewGO, "viewport/content/item5/#drop_item5_1")
	self._dropitem52 = gohelper.findChildDropdown(self.viewGO, "viewport/content/item5/#drop_item5_2")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GM_ArcadeView:addEvents()
	self._btnitem1:AddClickListener(self._btnitem1OnClick, self)
	self._btnitem3:AddClickListener(self._btnitem3OnClick, self)
	self._btnitem5:AddClickListener(self._btnitem5OnClick, self)
	self._btnitem2:AddClickListener(self._btnitem2OnClick, self)
	self._btnitem4:AddClickListener(self._btnitem4OnClick, self)
	self._btnClose:AddClickListener(self.closeThis, self)
	self._dropitem51:AddOnValueChanged(self._onDropItem51ValueChanged, self)
	self._dropitem52:AddOnValueChanged(self._onDropItem52ValueChanged, self)
end

function GM_ArcadeView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnitem1:RemoveClickListener()
	self._btnitem3:RemoveClickListener()
	self._btnitem5:RemoveClickListener()
	self._btnitem2:RemoveClickListener()
	self._btnitem4:RemoveClickListener()
	self._dropitem51:RemoveOnValueChanged()
	self._dropitem52:RemoveOnValueChanged()
end

function GM_ArcadeView:_btnitem5OnClick()
	local gmFormat = "arcadeLightUpHandBook %s %s"

	if self._dropItem51Index and self._dropItem51Params and self._dropItem52Index then
		local param = self._dropItem51Params[self._dropItem51Index]
		local infoType = param and param.param.InfoType
		local type = param and param.type

		if type and self._dropItem52Mos then
			local mo = self._dropItem52Mos[self._dropItem52Index]

			if mo then
				if mo.isAll then
					for _, _mo in ipairs(self._dropItem52Mos) do
						if not _mo.isAll then
							local gm = string.format(gmFormat, infoType, _mo:getEleId())

							GMRpc.instance:sendGMRequest(gm)
							GameFacade.showToast(ToastEnum.IconId, gm)
						end
					end
				else
					local gm = string.format(gmFormat, infoType, mo:getEleId())

					GMRpc.instance:sendGMRequest(gm)
					GameFacade.showToast(ToastEnum.IconId, gm)
				end

				self:initDropItem52()
			end
		end
	end
end

function GM_ArcadeView:_onDropItem51ValueChanged(index)
	local isChange = self._dropItem51Index ~= index + 1

	self._dropItem51Index = index + 1

	if isChange then
		self:initDropItem52()
	end
end

function GM_ArcadeView:_onDropItem52ValueChanged(index)
	self._dropItem52Index = index + 1
end

function GM_ArcadeView:_btnitem1OnClick()
	local attrId = self._inputitem11:GetText()
	local key = self._inputitem12:GetText()
	local value = self._inputitem13:GetText()
	local gm = string.format("arcadeAddAttr %s %s %s", attrId, key, value)

	GMRpc.instance:sendGMRequest(gm)
	GameFacade.showToast(ToastEnum.IconId, gm)
end

function GM_ArcadeView:_btnitem3OnClick()
	local score = self._inputitem31:GetText()
	local gm = string.format("arcadeAddScore %s", score)

	GMRpc.instance:sendGMRequest(gm)
	GameFacade.showToast(ToastEnum.IconId, gm)
end

function GM_ArcadeView:_btnitem2OnClick()
	local gm = "arcadeUnlockAllRole"

	GMRpc.instance:sendGMRequest(gm)
	GameFacade.showToast(ToastEnum.IconId, gm)
end

function GM_ArcadeView:_btnitem4OnClick()
	local gm = "arcadeReset"

	ArcadeOutSizeModel.instance:clearAllPrefs()
	GMRpc.instance:sendGMRequest(gm)
	GameFacade.showToast(ToastEnum.IconId, gm)
end

function GM_ArcadeView:_editableInitView()
	self:initDropItem51()
	self:initDropItem52()
end

function GM_ArcadeView:onUpdateParam()
	return
end

function GM_ArcadeView:onOpen()
	return
end

function GM_ArcadeView:initDropItem51()
	self._dropitem51:ClearOptions()

	local filterName = {}

	self._dropItem51Params = {}

	for type, param in pairs(ArcadeEnum.HandBookParams) do
		local v = {
			type = type,
			param = param
		}

		table.insert(self._dropItem51Params, v)
	end

	for _, param in ipairs(self._dropItem51Params) do
		table.insert(filterName, param.type)
	end

	self._dropItem51Index = 1

	self._dropitem51:AddOptions(filterName)
	self._dropitem51:SetValue(0)
end

function GM_ArcadeView:initDropItem52()
	self._dropitem52:ClearOptions()

	local filterName = {}

	self._dropItem52Mos = {}

	if self._dropItem51Params and self._dropItem51Index then
		local type = self._dropItem51Params[self._dropItem51Index].type
		local mos = ArcadeHandBookModel.instance:getMoListByType(type)

		for _, mo in ipairs(mos) do
			if mo:isLock() then
				table.insert(self._dropItem52Mos, mo)
			end
		end

		if #self._dropItem52Mos > 0 then
			table.insert(self._dropItem52Mos, 1, {
				isAll = true
			})
		end

		for i, mo in ipairs(self._dropItem52Mos) do
			if mo.isAll then
				table.insert(filterName, "All")
			else
				table.insert(filterName, mo:getEleId() .. "  " .. mo:getName())
			end
		end
	end

	self._dropItem52Index = 1

	self._dropitem52:AddOptions(filterName)
	self._dropitem52:SetValue(0)
end

function GM_ArcadeView:onClose()
	return
end

function GM_ArcadeView:onDestroyView()
	return
end

return GM_ArcadeView
