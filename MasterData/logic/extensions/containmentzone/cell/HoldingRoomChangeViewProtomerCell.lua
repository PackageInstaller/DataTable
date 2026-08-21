-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/cell/HoldingRoomChangeViewProtomerCell.lua

module("logic.extensions.containmentzone.cell.HoldingRoomChangeViewProtomerCell", package.seeall)

local M = class("HoldingRoomChangeViewProtomerCell", UIReusableLuaBehavior)

function M:buildUI()
	self._goContent = goutil.findChild(self.mainGO, "content")
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "content/icon")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "content/txtName")
	self._txtResearch = goutil.findChildTextComponent(self.mainGO, "content/txtResearchPoint")
	self._goHoldingMark = goutil.findChild(self.mainGO, "content/holdingName")
	self._txtHoldingRoom = goutil.findChildTextComponent(self.mainGO, "content/holdingName/txtHoldingName")
	self._goPrototypeGroup = goutil.findChild(self.mainGO, "content/prototypeGroup")
	self._goPrototypeItem = goutil.findChild(self.mainGO, "content/prototypeGroup/prototype_item")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "content/click").gameObject)
	self._animation = self.mainGO:GetComponent(ComponentType.Animation)
	self._goLock = goutil.findChild(self.mainGO, "content/lock")
	self._goSelect = goutil.findChild(self.mainGO, "content/select")
end

function M:destroyUI()
	self._goContent = nil
	self._imgIcon = nil
	self._txtName = nil
	self._txtResearch = nil
	self._goHoldingMark = nil
	self._txtHoldingRoom = nil
	self._goPrototypeGroup = nil
	self._goPrototypeItem = nil
	self._btnClick = nil
	self._id = nil
	self._unLock = nil
	self._handler = nil
	self._animation = nil
	self._goLock = nil
	self._goSelect = nil
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	self._handler = nil

	self._animation:Stop()
end

function M:setShow(show)
	goutil.setActive(self._goContent, show)
end

function M:getId()
	return self._id
end

function M:getIsUnLock()
	return self._unLock
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setDataByCfg(protomerCfg)
	self._id = protomerCfg.id

	local backPackConfig = ContainmentConfig.instance:getProtomerBackpackCfg(self._id)

	self:setName(backPackConfig.name)
	self:setIcon(self._id)

	local protomerInfo = ProtomerModel.instance:getProtomerInfo(self._id)

	self._unLock = protomerInfo ~= nil

	if self._unLock then
		self:setResearch(string.format(lang("tip_study_point_d"), protomerInfo:getResearchPoint()))
		self:setPrototypeIcon(protomerInfo:getProtomerPrototypeTableLst())
	else
		self:setResearch(lang("tip_look_unlock_condition"))
		self:setPrototypeIcon(ContainmentConfig.instance:getProtomerPrototypeCoLstByProtomerId(self._id))
	end

	goutil.setActive(self._goLock.gameObject, not self._unLock)

	local inRoomId = ProtomerModel.instance:getProtomerRoomId(self._id)

	self:setHoldingRoom(inRoomId)
end

function M:refreshSelect(selectProtomerId)
	goutil.setActive(self._goSelect.gameObject, self._id == selectProtomerId)
end

function M:setIcon(protomerId)
	ContainmentUtil.setProtomerDynIcon(self._imgIcon, protomerId)
end

function M:setName(contentTxt)
	self._txtName.text = contentTxt
end

function M:setResearch(content)
	self._txtResearch.text = content
end

function M:setPrototypeIcon(tablePrototypeLst)
	local count = #tablePrototypeLst

	while count > self._goPrototypeGroup.transform.childCount do
		goutil.cloneAndSetParent(self._goPrototypeItem, self._goPrototypeGroup.transform)
	end

	for i = 0, self._goPrototypeGroup.transform.childCount - 1 do
		local tmpGo = self._goPrototypeGroup.transform:GetChild(i).gameObject
		local show = i < #tablePrototypeLst

		if show then
			local iconUrl = tablePrototypeLst[i + 1].icon
			local imgPro = goutil.addComponentOnce(tmpGo, goutil.Type_UIImage)

			IconLoader.setSprite(imgPro, IconType.DynSpriteAtlas_Room, iconUrl)
		end

		goutil.setActive(tmpGo, show)
	end
end

function M:setHoldingRoom(roomId)
	if roomId and roomId > 0 then
		local roomInfo = ContainmentModel.instance:getRoomInfoById(roomId)

		self._txtHoldingRoom.text = roomInfo:getRoomIDName()

		goutil.setActive(self._goHoldingMark, true)
	else
		goutil.setActive(self._goHoldingMark, false)
	end
end

function M:_onClick()
	if self._handler then
		self._handler:onProtomerCellClick(self)
	end
end

function M:playOpenAni()
	self._animation:Stop()
	self._animation:Play("holding_goods_item")
end

function M:fixAni()
	return
end

return M
