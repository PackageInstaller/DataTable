-- chunkname: @modules/logic/summonsimulationpick/view/SummonSimulationPickResultItem.lua

module("modules.logic.summonsimulationpick.view.SummonSimulationPickResultItem", package.seeall)

local SummonSimulationPickResultItem = class("SummonSimulationPickResultItem", LuaCompBase)

function SummonSimulationPickResultItem:init(go)
	self.go = go
	self._btnclick = gohelper.findChildButton(self.go, "#btn_click")
	self._goselected = gohelper.findChild(self.go, "#go_selected")
	self._txtindex = gohelper.findChildTextMesh(self.go, "#go_selected/#txt_index")
	self._gounselect = gohelper.findChild(self.go, "#go_unselect")
	self._txtunselectIndex = gohelper.findChildTextMesh(self.go, "#go_unselect/#txt_unselectIndex")
	self._goheroitem = gohelper.findChild(self.go, "#go_heroitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonSimulationPickResultItem:_editableInitView()
	gohelper.setActive(self._goheroitem, false)
end

function SummonSimulationPickResultItem:addEventListeners()
	self._btnclick:AddClickListener(self._onbtnclickOnClick, self)
end

function SummonSimulationPickResultItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function SummonSimulationPickResultItem:_onbtnclickOnClick()
	local curSelectIndex = SummonSimulationPickModel.instance:getCurSelectIndex()

	if curSelectIndex and curSelectIndex == self._index then
		return
	end

	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onSelectItem, self._index)
end

function SummonSimulationPickResultItem:setInfo(info, index)
	self._index = index

	local title = luaLang("summonsimulation_result_title_" .. tostring(index))

	self._txtindex.text = title
	self._txtunselectIndex.text = title

	gohelper.CreateObjList(self, self.onItemShow, info, self._goheroitem.transform.parent.gameObject, self._goheroitem, SummonSimulationPickResultHeroItem, nil, nil, 3)
end

function SummonSimulationPickResultItem:onItemShow(item, data, index)
	item:setInfo(data, self._index)
end

function SummonSimulationPickResultItem:setSelect(isSelect)
	gohelper.setActive(self._goselected, isSelect)
	gohelper.setActive(self._gounselect, not isSelect)
end

function SummonSimulationPickResultItem:onDestroy()
	return
end

return SummonSimulationPickResultItem
