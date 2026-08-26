-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3SignInRoleTalkView.lua

module("modules.logic.turnback.view.turnback3.Turnback3SignInRoleTalkView", package.seeall)

local Turnback3SignInRoleTalkView = class("Turnback3SignInRoleTalkView", BaseView)

function Turnback3SignInRoleTalkView:onInitView()
	self._btnfullclosebtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_fullclose")
	self._btnclosebtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_closebtn")
	self._txtrolename = gohelper.findChildText(self.viewGO, "root/#txt_rolename")
	self._txttalk = gohelper.findChildText(self.viewGO, "root/#txt_talk")
	self._gorewardlist = gohelper.findChild(self.viewGO, "root/#go_rewardlist")
	self._gorewardlistitem = gohelper.findChild(self.viewGO, "root/#go_rewardlist/#go_reward_item")
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "root/imagerole_mask/#simage_role")
	self._simagerolename = gohelper.findChildSingleImage(self.viewGO, "root/#simage_signature")
	self._imagerole = gohelper.findChildImage(self.viewGO, "root/imagerole_mask/#simage_role")
	self._imagerolename = gohelper.findChildImage(self.viewGO, "root/#simage_signature")
	self.rewardList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback3SignInRoleTalkView:addEvents()
	self._btnfullclosebtn:AddClickListener(self._onClose, self)
	self._btnclosebtn:AddClickListener(self._onClose, self)
end

function Turnback3SignInRoleTalkView:removeEvents()
	self._btnfullclosebtn:RemoveClickListener()
	self._btnclosebtn:RemoveClickListener()
end

function Turnback3SignInRoleTalkView:_btnclosebtnOnClick()
	self:_onClose()
end

function Turnback3SignInRoleTalkView:_editableInitView()
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO.gameObject)

	NavigateMgr.instance:addEscape(self.viewName, self._onClose, self)
end

function Turnback3SignInRoleTalkView:onUpdateParam()
	return
end

function Turnback3SignInRoleTalkView:_onClose()
	self._animPlayer:Play("close", self.closeThis, self)
end

function Turnback3SignInRoleTalkView:onOpen()
	self.day = self.viewParam and self.viewParam.day
	self.isNormal = self.viewParam and self.viewParam.isNormal
	self.turnbackId = TurnbackModel.instance:getCurTurnbackId()
	self.config = TurnbackConfig.instance:getTurnbackSignInDayCo(self.turnbackId, self.day)

	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)
end

function Turnback3SignInRoleTalkView:refreshUI()
	if self.config then
		local heroId = self.config.characterId

		if heroId then
			local heroCo = HeroConfig.instance:getHeroCO(heroId)
			local skinId = heroCo and heroCo.skinId

			if skinId then
				self._simagerole:LoadImage(ResUrl.getHeadIconImg(skinId), self._loadedImage, self)
			end

			self._simagerolename:LoadImage(ResUrl.getSignature(heroCo.signature), self._loadedName, self)
		end

		self._txtrolename.text = self.config.name
		self._txttalk.text = self.config.content

		local bonusCo = GameUtil.splitString2(self.config.bonus, true)
		local count = #bonusCo

		self:_initRewardList(count, bonusCo)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
	end
end

function Turnback3SignInRoleTalkView:_initRewardList(count, bonusCo)
	for i = 1, count do
		local rewardItem = self.rewardList[i]

		if not rewardItem then
			rewardItem = self:getUserDataTb_()
			rewardItem.go = gohelper.clone(self._gorewardlistitem, self._gorewardlist, "item" .. i)
			rewardItem.goIcon = gohelper.findChild(rewardItem.go, "#go_item")
			rewardItem.gohasget = gohelper.findChild(rewardItem.go, "go_hasget")
			rewardItem.animGet = rewardItem.gohasget:GetComponent(typeof(UnityEngine.Animator))

			local co = bonusCo[i]
			local type, id, num = co[1], co[2], co[3]
			local config, icon = ItemModel.instance:getItemConfigAndIcon(type, id, true)

			if icon then
				if self.isNormal then
					rewardItem.itemIcon = IconMgr.instance:getCommonPropItemIcon(rewardItem.goIcon)

					gohelper.setActive(rewardItem.gohasget, true)
				else
					rewardItem.itemIcon = IconMgr.instance:getCommonPropListItemIcon(rewardItem.goIcon)
					rewardItem.itemIcon._index = i
				end

				rewardItem.itemIcon:setMOValue(type, id, num, nil, true)

				function rewardItem.itemIcon.callback(item)
					item:setCountFontSize(40)
				end
			end

			gohelper.setActive(rewardItem.go, true)
			table.insert(self.rewardList, rewardItem)
		end
	end

	if not self.isNormal then
		TaskDispatcher.runDelay(self._onAnimFinish, self, 0.5)
	end
end

function Turnback3SignInRoleTalkView:_onAnimFinish()
	for index, rewardItem in ipairs(self.rewardList) do
		gohelper.setActive(rewardItem.gohasget, true)
		rewardItem.animGet:Play("go_hasget_in", 0, 0)
	end
end

function Turnback3SignInRoleTalkView:_loadedImage()
	self._imagerole:SetNativeSize()
end

function Turnback3SignInRoleTalkView:_loadedName()
	self._imagerolename:SetNativeSize()
end

function Turnback3SignInRoleTalkView:onClose()
	if not self.isNormal then
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshSignInItem)
	end
end

function Turnback3SignInRoleTalkView:onDestroyView()
	return
end

return Turnback3SignInRoleTalkView
