-- chunkname: @modules/logic/versionactivity1_3/buff/view/VersionActivity1_3FairyLandView.lua

module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3FairyLandView", package.seeall)

local VersionActivity1_3FairyLandView = class("VersionActivity1_3FairyLandView", BaseView)

function VersionActivity1_3FairyLandView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_bg")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "root/#simage_bg2")
	self._imagetitle = gohelper.findChildImage(self.viewGO, "root/#image_title")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_confirm")
	self._gocontent = gohelper.findChild(self.viewGO, "root/#go_content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3FairyLandView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function VersionActivity1_3FairyLandView:removeEvents()
	self._btnconfirm:RemoveClickListener()
end

function VersionActivity1_3FairyLandView:_btnconfirmOnClick()
	if not self._useDreamCard then
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3SelectedDreamCard), self._selectedItem.config.id)
	end

	if self._selectedItem then
		Activity126Controller.instance:dispatchEvent(Activity126Event.selectDreamLandCard, self._selectedItem.config)
	end

	self:closeThis()
end

function VersionActivity1_3FairyLandView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getFairyLandIcon("v1a3_fairyland_bg"))
	self._simagebg2:LoadImage(ResUrl.getFairyLandIcon("v1a3_fairyland_bg2"))
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_seek_open)
end

function VersionActivity1_3FairyLandView:_initItems()
	self._itemList = self:getUserDataTb_()

	local itemPath = self.viewContainer:getSetting().otherRes[1]

	for i, v in ipairs(lua_activity126_dreamland_card.configList) do
		if self:_hasDreamCard(v.id) then
			local itemGo = self:getResInst(itemPath, self._gocontent)
			local landItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, VersionActivity1_3FairyLandItem, {
				self,
				v
			})

			table.insert(self._itemList, landItem)
		end
	end

	for i, v in ipairs(self._itemList) do
		if v.config == self._cardConfig then
			self:landItemClick(v)

			break
		end
	end
end

function VersionActivity1_3FairyLandView:_hasDreamCard(id)
	if self._taskConfig and self._useDreamCard then
		return string.find(self._taskConfig.dreamCards, id)
	end

	return Activity126Model.instance:hasDreamCard(id)
end

function VersionActivity1_3FairyLandView:landItemClick(item)
	self._selectedItem = item

	for i, v in ipairs(self._itemList) do
		v:setSelected(v == item)
	end
end

function VersionActivity1_3FairyLandView:onUpdateParam()
	return
end

function VersionActivity1_3FairyLandView:onOpen()
	self._taskConfig = self.viewParam[1]
	self._cardConfig = self.viewParam[2]
	self._useDreamCard = not string.nilorempty(self._taskConfig.dreamCards)

	self:_initItems()
end

function VersionActivity1_3FairyLandView:onClose()
	return
end

function VersionActivity1_3FairyLandView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagebg2:UnLoadImage()
end

return VersionActivity1_3FairyLandView
