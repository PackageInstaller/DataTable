-- chunkname: @modules/logic/room/view/debug/RoomDebugSelectPackageView.lua

module("modules.logic.room.view.debug.RoomDebugSelectPackageView", package.seeall)

local RoomDebugSelectPackageView = class("RoomDebugSelectPackageView", BaseView)

function RoomDebugSelectPackageView:onInitView()
	self._gopackageitem = gohelper.findChild(self.viewGO, "scroll_package/viewport/content/#go_packageitem")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_layout/#btn_add")
	self._btncopy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_layout/#btn_copy")
	self._goselectcopy = gohelper.findChild(self.viewGO, "#go_layout/#btn_copy/#go_selectcopy")
	self._btndelete = gohelper.findChildButtonWithAudio(self.viewGO, "#go_layout/#btn_delete")
	self._goselectdelete = gohelper.findChild(self.viewGO, "#go_layout/#btn_delete/#go_selectdelete")
	self._btnrename = gohelper.findChildButtonWithAudio(self.viewGO, "#go_layout/#btn_rename")
	self._goselectrename = gohelper.findChild(self.viewGO, "#go_layout/#btn_rename/#go_selectrename")
	self._btnchangemapid = gohelper.findChildButtonWithAudio(self.viewGO, "#go_layout/#btn_changId")
	self._goselectchangmapid = gohelper.findChild(self.viewGO, "#go_layout/#btn_changId/#go_selectrename")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomDebugSelectPackageView:addEvents()
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btncopy:AddClickListener(self._btncopyOnClick, self)
	self._btndelete:AddClickListener(self._btndeleteOnClick, self)
	self._btnrename:AddClickListener(self._btnrenameOnClick, self)
	self._btnchangemapid:AddClickListener(self._btnchangemapidOnClick, self)
end

function RoomDebugSelectPackageView:removeEvents()
	self._btnadd:RemoveClickListener()
	self._btncopy:RemoveClickListener()
	self._btndelete:RemoveClickListener()
	self._btnrename:RemoveClickListener()
	self._btnchangemapid:RemoveClickListener()
end

function RoomDebugSelectPackageView:_btnaddOnClick()
	RoomDebugController.instance:getDebugPackageInfo(function(package)
		local maxPackageMapId = 0

		for _, packageMap in ipairs(package) do
			if maxPackageMapId < packageMap.packageMapId then
				maxPackageMapId = packageMap.packageMapId
			end
		end

		GameFacade.openInputBox({
			characterLimit = 100,
			sureBtnName = "确定",
			title = "输入新地图名",
			cancelBtnName = "取消",
			defaultInput = string.format("地图%d", maxPackageMapId + 1),
			sureCallback = function(packageName)
				self:_addCallback(package, maxPackageMapId, packageName)
			end
		})
	end)
end

function RoomDebugSelectPackageView:_addCallback(package, maxPackageMapId, packageName)
	packageName = packageName or string.format("地图%d", maxPackageMapId)

	for _, packageMap in ipairs(package) do
		if not packageMap.packageName then
			local name = string.format("地图%d", packageMap.packageMapId)

			if packageMap.packageName == packageName then
				logError("重名")

				return
			end
		end
	end

	RoomDebugController.instance:resetPackageJson(maxPackageMapId + 1, packageName)
	self:_refreshUI()
	GameFacade.closeInputBox()
end

function RoomDebugSelectPackageView:_btncopyOnClick()
	self:_clickSelectOp(2)
end

function RoomDebugSelectPackageView:_copyCallback(copyPackageMapId, maxPackageMapId, packageName)
	RoomDebugController.instance:copyPackageJson(maxPackageMapId + 1, packageName, copyPackageMapId)
	self:_refreshUI()
	GameFacade.closeInputBox()
end

function RoomDebugSelectPackageView:_btndeleteOnClick()
	self:_clickSelectOp(3)
end

function RoomDebugSelectPackageView:_btnClickOnClick(index)
	local packageItem = self._packageItemList[index]

	if not packageItem then
		return
	end

	if self._selectOp == 1 then
		RoomController.instance:enterRoom(RoomEnum.GameMode.DebugPackage, nil, nil, {
			packageMapId = packageItem.packageMapId
		})
		ViewMgr.instance:closeAllPopupViews()
	elseif self._selectOp == 2 then
		RoomDebugController.instance:getDebugPackageInfo(function(package)
			local maxPackageMapId = 0

			for _, packageMap in ipairs(package) do
				if maxPackageMapId < packageMap.packageMapId then
					maxPackageMapId = packageMap.packageMapId
				end
			end

			GameFacade.openInputBox({
				characterLimit = 100,
				sureBtnName = "确定",
				title = "输入新地图名",
				cancelBtnName = "取消",
				defaultInput = string.format("地图%d", maxPackageMapId + 1),
				sureCallback = function(packageName)
					self:_copyCallback(packageItem.packageMapId, maxPackageMapId, packageName)
				end
			})
		end)
	elseif self._selectOp == 3 then
		RoomDebugController.instance:deletePackageJson(packageItem.packageMapId)
		self:_refreshUI()
	elseif self._selectOp == 4 then
		local packageName = string.nilorempty(packageItem.packageName) and string.format("地图%d", packageItem.packageMapId) or packageItem.packageName

		GameFacade.openInputBox({
			characterLimit = 100,
			sureBtnName = "确定",
			title = "输入新地图名",
			cancelBtnName = "取消",
			defaultInput = packageName,
			sureCallback = function(packageName)
				self:_renameCallback(packageItem.packageMapId, packageName)
			end
		})
	elseif self._selectOp == 5 then
		local packageName = string.nilorempty(packageItem.packageName) and string.format("地图%d", packageItem.packageMapId) or packageItem.packageName

		GameFacade.openInputBox({
			characterLimit = 100,
			sureBtnName = "确定",
			cancelBtnName = "取消",
			title = string.format("当前MapId:%s", packageItem.packageMapId),
			defaultInput = packageItem.packageMapId,
			sureCallback = function(newPackageMapId)
				self:_changemapidCallback(packageItem.packageMapId, tonumber(newPackageMapId))
			end
		})
	end
end

function RoomDebugSelectPackageView:_btnrenameOnClick()
	self:_clickSelectOp(4)
end

function RoomDebugSelectPackageView:_renameCallback(packageMapId, packageName)
	RoomDebugController.instance:renamePackageJson(packageMapId, packageName)
	self:_refreshUI()
	GameFacade.closeInputBox()
end

function RoomDebugSelectPackageView:_btnchangemapidOnClick()
	if self._selectOp ~= 5 then
		MessageBoxController.instance:showMsgBoxByStr("注意只能修改未上线的版本【新地块】，解决BlockId冲突的问题!", MsgBoxEnum.BoxType.Yes)
	end

	self:_clickSelectOp(5)
end

function RoomDebugSelectPackageView:_changemapidCallback(packageMapId, newPackageMapId)
	if packageMapId == newPackageMapId then
		GameFacade.closeInputBox()

		return
	end

	if not newPackageMapId then
		GameFacade.showToastString("packageMapId不能为空")

		return
	end

	RoomDebugController.instance:getDebugPackageInfo(function(package)
		for _, packageMap in ipairs(package) do
			if packageMap.packageMapId == newPackageMapId then
				GameFacade.showToastString(string.format("packageMapId:%s 已存在，请检查", newPackageMapId))

				return
			end
		end

		if packageMapId ~= newPackageMapId then
			RoomDebugController.instance:changePackageMapIdJson(packageMapId, newPackageMapId)
			self:_refreshUI()
		end

		GameFacade.closeInputBox()
	end)
end

function RoomDebugSelectPackageView:_editableInitView()
	gohelper.setActive(self._gopackageitem, false)

	self._packageItemList = {}
	self._selectOp = 1

	gohelper.setActive(self._goselectcopy, false)
	gohelper.setActive(self._goselectdelete, false)
	gohelper.setActive(self._goselectrename, false)
	gohelper.setActive(self._goselectchangmapid, false)
end

function RoomDebugSelectPackageView:_clickSelectOp(selectOp)
	self._selectOp = self._selectOp == selectOp and 1 or selectOp

	gohelper.setActive(self._goselectcopy, self._selectOp == 2)
	gohelper.setActive(self._goselectdelete, self._selectOp == 3)
	gohelper.setActive(self._goselectrename, self._selectOp == 4)
	gohelper.setActive(self._goselectchangmapid, self._selectOp == 5)
end

function RoomDebugSelectPackageView:_refreshUI()
	RoomDebugController.instance:getDebugPackageInfo(function(package)
		local blockIdDict = {}

		for i, packageMap in ipairs(package) do
			for _, info in ipairs(packageMap.infos) do
				if blockIdDict[info.blockId] then
					logError("重复的blockId: " .. info.blockId)
				end

				blockIdDict[info.blockId] = true
			end

			local packageItem = self._packageItemList[i]

			if not packageItem then
				packageItem = self:getUserDataTb_()
				packageItem.index = i
				packageItem.go = gohelper.cloneInPlace(self._gopackageitem, "item" .. i)
				packageItem.txtid = gohelper.findChildText(packageItem.go, "txt_id")
				packageItem.btnclick = gohelper.findChildButtonWithAudio(packageItem.go, "btn_click")

				packageItem.btnclick:AddClickListener(self._btnClickOnClick, self, packageItem.index)
				table.insert(self._packageItemList, packageItem)
			end

			packageItem.packageMapId = packageMap.packageMapId
			packageItem.txtid.text = string.nilorempty(packageMap.packageName) and string.format("地图%d", packageMap.packageMapId) or packageMap.packageName

			gohelper.setActive(packageItem.go, true)
		end

		for i = #package + 1, #self._packageItemList do
			local packageItem = self._packageItemList[i]

			gohelper.setActive(packageItem.go, false)
		end
	end)
end

function RoomDebugSelectPackageView:onOpen()
	self:_refreshUI()
end

function RoomDebugSelectPackageView:onClose()
	return
end

function RoomDebugSelectPackageView:onDestroyView()
	for i, packageItem in ipairs(self._packageItemList) do
		packageItem.btnclick:RemoveClickListener()
	end
end

return RoomDebugSelectPackageView
