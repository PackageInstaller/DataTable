-- chunkname: @modules/logic/player/view/IconTipView.lua

module("modules.logic.player.view.IconTipView", package.seeall)

local IconTipView = class("IconTipView", BaseView)

function IconTipView:onInitView()
	self._simagetop = gohelper.findChildSingleImage(self.viewGO, "window/bg/#simage_top")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "window/bg/#simage_bottom")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "window/right/useState/#btn_change")
	self._txtnameCn = gohelper.findChildText(self.viewGO, "window/right/#txt_nameCn")
	self._gousing = gohelper.findChild(self.viewGO, "window/right/useState/#go_using")
	self._simageheadIcon = gohelper.findChildSingleImage(self.viewGO, "window/right/#simage_headIcon")
	self._gomainsignature = gohelper.findChild(self.viewGO, "window/right/signname")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "window/right/signname2")
	self._goframenode = gohelper.findChild(self.viewGO, "window/right/#simage_headIcon/#go_framenode")
	self._btncloseBtn = gohelper.findChildButtonWithAudio(self.viewGO, "window/top/#btn_closeBtn")
	self._btnSwitchLeft = gohelper.findChildButtonWithAudio(self.viewGO, "window/right/Btn_SwitchLeft")
	self._btnSwitchRight = gohelper.findChildButtonWithAudio(self.viewGO, "window/right/Btn_SwitchRight")
	self._loader = MultiAbLoader.New()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function IconTipView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncloseBtn:AddClickListener(self._btncloseBtnOnClick, self)
	self._btnSwitchLeft:AddClickListener(self._btnSwitchBtnOnClick, self, false)
	self._btnSwitchRight:AddClickListener(self._btnSwitchBtnOnClick, self, true)
end

function IconTipView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncloseBtn:RemoveClickListener()
	self._btnSwitchLeft:RemoveClickListener()
	self._btnSwitchRight:RemoveClickListener()
end

function IconTipView:_btnconfirmOnClick()
	local portrait

	if self._curSwitchIndex and self._switchHeadIdList then
		portrait = self._switchHeadIdList[self._curSwitchIndex]

		if self._switchHeadIdList[self._curSwitchIndex] == nil then
			logError("不存在的镀层头像索引")

			return
		end
	else
		portrait = IconTipModel.instance:getSelectIcon()
	end

	PlayerRpc.instance:sendSetPortraitRequest(portrait)
end

function IconTipView:_btncloseBtnOnClick()
	self:closeThis()
end

function IconTipView:_btnSwitchBtnOnClick(add)
	local index = self._curSwitchIndex

	index = add and math.min(index + 1, self._switchHeadIdCount) or math.max(index - 1, 1)

	local portrait = self._switchHeadIdList[index]

	if portrait == nil then
		logError("index outof range")

		return
	end

	IconTipModel.instance:setSelectIcon(portrait)
	self:_refreshSwitchBtnState(index)

	local config = lua_item.configDict[portrait]

	self:_setHeadIcon(config)
end

function IconTipView:_editableInitView()
	local playerinfo = PlayerModel.instance:getPlayinfo()

	IconTipModel.instance:setSelectIcon(playerinfo.portrait)
	IconTipModel.instance:setIconList(playerinfo.portrait)
	self._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	self._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))

	self._buttonbg = gohelper.findChildClick(self.viewGO, "maskbg")

	self._buttonbg:AddClickListener(self._btncloseBtnOnClick, self)
end

function IconTipView:onUpdateParam()
	self:_refreshUI()
end

function IconTipView:_refreshUI()
	local selectIcon = IconTipModel.instance:getSelectIcon()
	local playerinfo = PlayerModel.instance:getPlayinfo()
	local usedIcon = playerinfo.portrait

	self._usedIcon = usedIcon

	gohelper.setActive(self._btnconfirm.gameObject, selectIcon ~= usedIcon)
	gohelper.setActive(self._gousing, selectIcon == usedIcon)

	local config = lua_item.configDict[selectIcon]

	self._txtnameCn.text = config.name

	self:_setHeadIcon(config)
	gohelper.setActive(self._btnSwitchLeft.gameObject, false)
	gohelper.setActive(self._btnSwitchRight.gameObject, false)

	self._curSwitchIndex = nil
	self._switchHeadIdList = nil
	self._switchHeadIdCount = nil

	if string.nilorempty(config.effect) then
		return
	end

	local switchParamData = string.splitToNumber(config.effect, "#")

	if switchParamData == nil then
		return
	end

	local count = #switchParamData

	if count <= 0 then
		return
	end

	self._switchHeadIdCount = 0
	self._switchHeadIdList = {}

	for index, id in ipairs(switchParamData) do
		if ItemModel.instance:getById(id) ~= nil then
			table.insert(self._switchHeadIdList, id)

			self._switchHeadIdCount = self._switchHeadIdCount + 1
		end
	end

	if self._switchHeadIdCount <= 0 then
		return
	end

	local curIndex

	for index, id in ipairs(self._switchHeadIdList) do
		if id == selectIcon then
			curIndex = index
		end
	end

	if curIndex == nil then
		logError("没有找到编号为 ：" .. selectIcon .. "的镀层头像")

		return
	end

	self:_refreshSwitchBtnState(curIndex)
end

function IconTipView:_setHeadIcon(config)
	if config == nil then
		logError("头像为空")

		return
	end

	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simageheadIcon)

	self._liveHeadIcon:setLiveHead(config.id)

	local signature = "qianming"

	if config.headIconSign and not string.nilorempty(config.headIconSign) then
		signature = config.headIconSign

		gohelper.setActive(self._gomainsignature, false)
		gohelper.setActive(self._simagesignature.gameObject, true)
		self._simagesignature:LoadImage(ResUrl.getSignature(signature, "rolehead"), self._onSignatureImageLoad, self)
	else
		gohelper.setActive(self._gomainsignature, true)
		gohelper.setActive(self._simagesignature.gameObject, false)
	end

	local effectArr = string.split(config.effect, "#")

	if #effectArr > 1 then
		if config.id == tonumber(effectArr[#effectArr]) then
			gohelper.setActive(self._goframenode, true)

			if not self.frame then
				local framePath = "ui/viewres/common/effect/frame.prefab"

				self._loader:addPath(framePath)
				self._loader:startLoad(self._onLoadCallback, self)
			end
		end
	else
		gohelper.setActive(self._goframenode, false)
	end
end

function IconTipView:_onSignatureImageLoad()
	ZProj.UGUIHelper.SetImageSize(self._simagesignature.gameObject)
end

function IconTipView:_refreshSwitchBtnState(curIndex)
	self._curSwitchIndex = curIndex

	local portrait = self._switchHeadIdList[curIndex]

	gohelper.setActive(self._btnSwitchLeft.gameObject, curIndex > 1)
	gohelper.setActive(self._btnSwitchRight.gameObject, curIndex < self._switchHeadIdCount)
	gohelper.setActive(self._btnconfirm, portrait ~= self._usedIcon)
end

function IconTipView:_onLoadCallback()
	local framePrefab = self._loader:getFirstAssetItem():GetResource()

	gohelper.clone(framePrefab, self._goframenode, "frame")

	self.frame = gohelper.findChild(self._goframenode, "frame")

	local img = self.frame:GetComponent(gohelper.Type_Image)

	img.enabled = false

	local iconwidth = recthelper.getWidth(self._simageheadIcon.transform)
	local framenodewidth = recthelper.getWidth(self.frame.transform)
	local scale = 1.41 * (iconwidth / framenodewidth)

	transformhelper.setLocalScale(self.frame.transform, scale, scale, 1)
end

function IconTipView:onOpen()
	self.addEventCb(self, PlayerController.instance, PlayerEvent.SelectPortrait, self._refreshUI, self)
	self.addEventCb(self, PlayerController.instance, PlayerEvent.SetPortrait, self._refreshUI, self)
	self:_refreshUI()
end

function IconTipView:onClose()
	self.removeEventCb(self, PlayerController.instance, PlayerEvent.SelectPortrait, self._refreshUI, self)
	self.removeEventCb(self, PlayerController.instance, PlayerEvent.SetPortrait, self._refreshUI, self)
end

function IconTipView:onDestroyView()
	self._simageheadIcon:UnLoadImage()
	self._buttonbg:RemoveClickListener()

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return IconTipView
