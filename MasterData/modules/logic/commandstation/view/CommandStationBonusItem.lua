-- chunkname: @modules/logic/commandstation/view/CommandStationBonusItem.lua

module("modules.logic.commandstation.view.CommandStationBonusItem", package.seeall)

local CommandStationBonusItem = class("CommandStationBonusItem", MixScrollCell)

function CommandStationBonusItem:init(go)
	self.go = go
	self._goGrey = gohelper.findChild(go, "point/grey")
	self._txtPoint = gohelper.findChildTextMesh(go, "point/#txt_point")
end

function CommandStationBonusItem:onUpdateMO(mo)
	local totalItemNum = CommandStationConfig.instance:getCurPaperCount()
	local isGet = tabletool.indexOf(CommandStationModel.instance.gainBonus, mo.id)
	local canGet = not isGet and totalItemNum >= mo.pointNum
	local item_list = ItemModel.instance:getItemDataListByConfigStr(mo.bonus)

	gohelper.setActive(self._goGrey, totalItemNum < mo.pointNum)

	self._txtPoint.text = mo.pointNum

	for i = 1, 2 do
		local go = gohelper.findChild(self.go, tostring(i))

		self:_refreshItem(go, item_list[i], isGet, canGet)
	end
end

function CommandStationBonusItem:_refreshItem(go, data, isGet, isCanGet)
	if not data then
		gohelper.setActive(go, false)

		return
	end

	gohelper.setActive(go, true)

	local go_canget = gohelper.findChild(go, "go_canget")
	local btn_click = gohelper.findChildButtonWithAudio(go, "go_canget/btn_click")
	local go_receive = gohelper.findChild(go, "go_receive")
	local go_icon = gohelper.findChild(go, "go_icon")

	gohelper.setActive(go_canget, isCanGet)
	gohelper.setActive(go_receive, isGet)

	local item

	if go_icon.transform.childCount > 0 then
		item = MonoHelper.getLuaComFromGo(go_icon.transform:GetChild(go_icon.transform.childCount - 1).gameObject, CommonPropItemIcon)
	end

	item = item or IconMgr.instance:getCommonPropItemIcon(go_icon)

	item:onUpdateMO(data)
	item:setConsume(true)
	item:showStackableNum2()
	item:isShowEffect(true)
	item:setAutoPlay(true)
	item:setCountFontSize(48)
	self.addClickCb(self, btn_click, self._sendGetAllBonus, self)
end

function CommandStationBonusItem:_sendGetAllBonus()
	CommandStationRpc.instance:sendCommandPostBonusAllRequest()
end

return CommandStationBonusItem
