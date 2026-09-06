-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/SummonDebugView.lua

module("logic.extensions.gm.view.SummonDebugView", package.seeall)

local SummonDebugView = class("SummonDebugView", ViewComponent)

function SummonDebugView:ctor()
	SummonDebugView.super:ctor()
end

function SummonDebugView:buildUI()
	self._cell = self:getBtn("summonPanel/cell")
	self._txtName = self:getGo("summonPanel/txtName")
	self._summonPanel = self:getGo("summonPanel")
	self._editClosePanel = self:getBtn("summonPanel/container/closeBtn")
	self._btnContainer = self:getGo("summonPanel/container/btnContainer")
end

function SummonDebugView:onEnter()
	return
end

function SummonDebugView:bindEvents()
	self._editClosePanel:AddClickListener(self._onCloseClick, self)
end

function SummonDebugView:unbindEvents()
	self._editClosePanel:RemoveClickListener()
end

function SummonDebugView:_initAllChild()
	local arr = self._summonCfs
	local yidx = 0

	for i, tem in pairs(arr) do
		for mid, v in pairs(tem) do
			local txtClone = goutil.clone(self._txtName, "txt_" .. i)

			goutil.addChildToParent(txtClone, self._btnContainer)

			goutil.findChildTextComponent(txtClone, "Text").text = CharacterConfig.instance:getPetCo(mid).name .. ": "

			txtClone.gameObject:SetActive(true)

			txtClone.transform.localPosition = Vector3.New(0, -yidx * 60, 0)

			local idx = 0

			for a, m in pairs(v) do
				for k, id in pairs(m.petRaceArr) do
					local petCO = CharacterConfig.instance:getPetCo(id)

					if petCO ~= nil then
						local cell = goutil.clone(self._cell, "cell_" .. id)

						cell.gameObject:SetActive(true)
						goutil.addChildToParent(cell, self._btnContainer)

						local txt = goutil.findChildTextComponent(cell, "Text")

						txt.text = petCO.name
						cell.transform.localPosition = Vector3.New(120 * math.floor(idx % 5), -yidx * 60, 0)
						idx = idx + 1

						cell:AddClickListener(function()
							self:localNotify(FightModel.EVENT_SUMMON_UPDATE, {
								idx = self._idx,
								type = self._type,
								id = id
							})
							self._summonPanel:SetActive(false)
						end)
					end
				end
			end

			yidx = yidx + math.ceil(idx / 5)
		end
	end
end

function SummonDebugView:onShowPanel(type, idx, tbl)
	self._type = type
	self._idx = idx
	self._summonCfs = tbl

	self._summonPanel:SetActive(true)
	goutil.clearChildren(self._btnContainer)
	self:_initAllChild()
end

function SummonDebugView:_onCloseClick()
	self._summonPanel:SetActive(false)
	self:localNotify(FightModel.EVENT_SUMMON_UPDATE, {
		id = 0,
		idx = self._idx,
		type = self._type
	})
end

return SummonDebugView
