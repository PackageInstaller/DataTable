-- chunkname: @modules/logic/room/view/building/RoomFormulaMsgBoxView.lua

module("modules.logic.room.view.building.RoomFormulaMsgBoxView", package.seeall)

local RoomFormulaMsgBoxView = class("RoomFormulaMsgBoxView", BaseView)
local SCROLL_VIEW_CENTER_POS_Y = -92.5

function RoomFormulaMsgBoxView:onInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_yes")
	self._txtyes = gohelper.findChildText(self.viewGO, "#btn_yes/yes")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_no")
	self._goScrollView = gohelper.findChild(self.viewGO, "Exchange/Left/ScrollView")
	self._goContent = gohelper.findChild(self.viewGO, "Exchange/Left/ScrollView/Viewport/Content")
	self._contentGrid = self._goContent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._goPropItem = gohelper.findChild(self.viewGO, "Exchange/Left/ScrollView/Viewport/Content/#go_PropItem")
	self._gorightContent = gohelper.findChild(self.viewGO, "Exchange/Right/ScrollView/Viewport/Content")
	self._gorightPropItem = gohelper.findChild(self.viewGO, "Exchange/Right/ScrollView/Viewport/Content/#go_PropItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomFormulaMsgBoxView:addEvents()
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
end

function RoomFormulaMsgBoxView:removeEvents()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
end

function RoomFormulaMsgBoxView:_btnyesOnClick()
	if not self.viewParam then
		return
	end

	local lineMO = RoomProductionModel.instance:getLineMO(self.viewParam.lineId)
	local callback = self.viewParam.callback

	if callback then
		self.viewParam.callback(self.viewParam.callbackObj)
	end

	RoomRpc.instance:sendStartProductionLineRequest(lineMO.id, self.viewParam.costItemAndFormulaIdList.formulaIdList, self.costItemList, self.viewParam.combineCb, self.viewParam.combineCbObj)
	self:closeThis()
end

function RoomFormulaMsgBoxView:_btnnoOnClick()
	self:closeThis()
end

function RoomFormulaMsgBoxView:_editableInitView()
	self._originalScrollViewPosX, self._originalScrollViewPosY, _ = transformhelper.getLocalPos(self._goScrollView.transform)

	gohelper.setActive(self._goPropItem, false)
end

function RoomFormulaMsgBoxView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
	self:setMatItemList()
	self:setProduceItemList()

	local yesStr = self.viewParam.combineCb and "roomformula_combine_and_up" or "confirm_text"

	self._txtyes.text = luaLang(yesStr)
end

function RoomFormulaMsgBoxView:setMatItemList()
	self.costItemList = {}
	self._contentGrid.enabled = false

	if self.viewParam then
		if self.viewParam then
			for type, itemDic in pairs(self.viewParam) do
				for itemId, quantity in pairs(itemDic) do
					if quantity > 0 then
						local item = {}

						item.type = type
						item.id = itemId
						item.quantity = quantity

						table.insert(self.costItemList, item)
					end
				end
			end
		end

		RoomFormulaMsgBoxModel.instance:setCostItemList(self.costItemList)

		local list = RoomFormulaMsgBoxModel.instance:getList()

		if #list <= self.viewContainer.lineCount then
			transformhelper.setLocalPosXY(self._goScrollView.transform, self._originalScrollViewPosX, SCROLL_VIEW_CENTER_POS_Y)

			self._contentGrid.enabled = true
		else
			self._contentGrid.enabled = false

			transformhelper.setLocalPosXY(self._goScrollView.transform, self._originalScrollViewPosX, self._originalScrollViewPosY)
		end
	end
end

function RoomFormulaMsgBoxView:setProduceItemList()
	self.produceItemList = {}

	if self.viewParam then
		if not self.viewParam.produceDataList then
			local produceDataList = {}

			gohelper.CreateObjList(self, self._onCreateProduceItem, produceDataList, self._gorightContent, self._gorightPropItem, RoomFormulaMsgBoxItem)

			local produceNameTable = {}

			for _, produceData in ipairs(produceDataList) do
				local config = ItemModel.instance:getItemConfigAndIcon(produceData.type, produceData.id)
				local numDisplay = GameUtil.numberDisplay(produceData.quantity)

				produceNameTable[#produceNameTable + 1] = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("multiple_2"), config.name, numDisplay)
			end

			local strComma = luaLang("comma_sep")
			local allNameWithNum = table.concat(produceNameTable, strComma)

			self._txtdesc.text = formatLuaLang("room_formula_easy_combine_msg_box_tip", allNameWithNum)
		end
	end
end

function RoomFormulaMsgBoxView:_onCreateProduceItem(obj, data, index)
	obj:onUpdateMO(data)

	self.produceItemList[index] = obj
end

function RoomFormulaMsgBoxView:onClose()
	return
end

return RoomFormulaMsgBoxView
