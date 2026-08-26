-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114MeetItem.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114MeetItem", package.seeall)

local Activity114MeetItem = class("Activity114MeetItem", BaseView)

function Activity114MeetItem:ctor(go)
	self.go = go
end

function Activity114MeetItem:onInitView()
	self._gohero = gohelper.findChild(self.go, "hero")
	self._gonohero = gohelper.findChild(self.go, "nohero")
	self._simagehero = gohelper.findChildSingleImage(self.go, "hero/simage_hero")
	self._simagesignature = gohelper.findChildSingleImage(self.go, "hero/simage_hero/simage_signature")
	self._txtname = gohelper.findChildTextMesh(self.go, "hero/info/txt_name")
	self._txtnameEn = gohelper.findChildTextMesh(self.go, "hero/info/txt_name/txt_nameen")
	self._txtcontent = gohelper.findChildTextMesh(self.go, "hero/info/#txt_content")
	self._simagenohero = gohelper.findChildSingleImage(self.go, "nohero/simage_nohero")
	self._btnmeet = gohelper.findChildButtonWithAudio(self.go, "hero/#btn_meet")
	self._gofinish = gohelper.findChild(self.go, "hero/#go_finish")
	self._txtfinish = gohelper.findChildTextMesh(self.go, "hero/#go_finish/cn")
	self._gopoint = gohelper.findChild(self.go, "hero/point/go_point")
	self._txttag = gohelper.findChildTextMesh(self.go, "hero/#txt_tag")
	self._imagetagicon = gohelper.findChildImage(self.go, "hero/#txt_tag/#image_tagicon")
	self._imageHero = self._simagehero:GetComponent(gohelper.Type_Image)
	self._imageNoHero = self._simagenohero:GetComponent(gohelper.Type_Image)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114MeetItem:addEvents()
	self._btnmeet:AddClickListener(self.onMeet, self)
end

function Activity114MeetItem:removeEvents()
	self._btnmeet:RemoveClickListener()
end

function Activity114MeetItem:updateMo(mo)
	self.mo = mo

	if mo then
		gohelper.setActive(self.go, true)

		local serverMo = Activity114Model.instance.unLockMeetingDict[self.mo.id]

		self._simagehero:LoadImage(ResUrl.getAct114MeetIcon("img_role_" .. mo.id), self.onLoadedEnd, self)
		self._simagenohero:LoadImage(ResUrl.getAct114MeetIcon("img_role_" .. mo.id), self.onLoadedEnd2, self)

		if serverMo then
			if not Activity114Model.instance:getIsPlayUnLock(Activity114Enum.EventType.Meet, self.mo.id) then
				self:playUnlockEffect()
			else
				gohelper.setActive(self._gohero, true)
				gohelper.setActive(self._gonohero, false)
			end

			self._txtname.text = self.mo.name
			self._txtcontent.text = self.mo.des
			self._txtnameEn.text = self.mo.nameEng

			self._simagesignature:LoadImage(ResUrl.getSignature(self.mo.signature))

			local attributeCo = Activity114Config.instance:getAttrCo(Activity114Model.instance.id, self.mo.tag)

			if attributeCo then
				self._txttag.text = attributeCo.attrName

				UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(self._imagetagicon, "icons_" .. attributeCo.attribute)
			end

			gohelper.setActive(self._txttag.gameObject, attributeCo)

			local events = string.splitToNumber(self.mo.events, "#")
			local nowTimes = serverMo.times
			local isFinish = nowTimes >= #events or serverMo.isBlock == 1

			if isFinish then
				self._txtfinish.text = serverMo.isBlock == 1 and luaLang("versionactivity_1_2_114meetblock") or luaLang("versionactivity_1_2_114meetfinish")
			end

			gohelper.setActive(self._gofinish, isFinish)
			gohelper.setActive(self._btnmeet.gameObject, serverMo.isBlock ~= 1 and not isFinish)

			self.points = self.points or {}

			for i = 1, #events do
				if not self.points[i] then
					self.points[i] = self:getUserDataTb_()
					self.points[i].go = gohelper.cloneInPlace(self._gopoint, "Point")

					gohelper.setActive(self.points[i].go, true)
				end

				self.points[i].event = events[i]

				local type = 1

				if nowTimes < i and serverMo.isBlock ~= 1 then
					type = 1

					local eventCo = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, events[i])

					if eventCo.config.isCheckEvent == 1 then
						type = eventCo.config.disposable == 1 and 6 or 7
					end

					if not Activity114Model.instance.unLockEventDict[events[i]] then
						local condition = string.splitToNumber(eventCo.config.condition, "#")

						if condition and #condition >= 2 and condition[1] == 2 and Activity114Model.instance.serverData.week <= condition[2] then
							type = 4

							if i == nowTimes + 1 then
								gohelper.setActive(self._gofinish, true)
								gohelper.setActive(self._btnmeet.gameObject, false)
							end
						end
					end
				elseif i < nowTimes or i == nowTimes and serverMo.isBlock ~= 1 then
					type = 2
				elseif i == nowTimes and serverMo.isBlock == 1 then
					type = 3
				elseif nowTimes < i and serverMo.isBlock == 1 then
					type = 4
				end

				for j = 1, 7 do
					local typeGo = gohelper.findChild(self.points[i].go, "type" .. j)

					gohelper.setActive(typeGo, type == j)
				end
			end

			local isRoundLock = self:isRoundLock()
			local isEventLock = #events >= nowTimes + 1 and not Activity114Model.instance.unLockEventDict[events[nowTimes + 1]]

			ZProj.UGUIHelper.SetGrayscale(self._btnmeet.gameObject, isEventLock or isRoundLock)
		else
			gohelper.setActive(self._gohero, false)
			gohelper.setActive(self._gonohero, true)
		end
	else
		gohelper.setActive(self.go, false)
	end
end

function Activity114MeetItem:playUnlockEffect()
	local animatorPlayer = SLFramework.AnimatorPlayer.Get(self.go)

	animatorPlayer:Stop()
	animatorPlayer:Play(UIAnimationName.Unlock, self.playUnlockEffectFinish, self)
	Activity114Model.instance:setIsPlayUnLock(Activity114Enum.EventType.Meet, self.mo.id)
end

function Activity114MeetItem:playUnlockEffectFinish()
	gohelper.setActive(self._gonohero, false)
end

function Activity114MeetItem:isRoundLock()
	local isRoundLock = false

	if not string.nilorempty(self.mo.banTurn) then
		local banTurn = string.splitToNumber(self.mo.banTurn, "#")

		if tabletool.indexOf(banTurn, Activity114Model.instance.serverData.round) then
			isRoundLock = true
		end
	end

	return isRoundLock
end

function Activity114MeetItem:onLoadedEnd()
	self._imageHero:SetNativeSize()
end

function Activity114MeetItem:onLoadedEnd2()
	self._imageNoHero:SetNativeSize()
end

function Activity114MeetItem:_editableInitView()
	gohelper.setActive(self._gopoint, false)
end

function Activity114MeetItem:onMeet()
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	local isRoundLock = self:isRoundLock()

	if isRoundLock then
		GameFacade.showToast(ToastEnum.Act114MeetLock)

		return
	end

	local serverMo = Activity114Model.instance.unLockMeetingDict[self.mo.id]

	if not Activity114Model.instance.unLockEventDict[self.points[serverMo.times + 1].event] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Summon.Play_UI_CallFor_Open)
	Activity114Rpc.instance:meetRequest(Activity114Model.instance.id, self.mo.id)
end

function Activity114MeetItem:onDestroyView()
	if self.points then
		for _, v in pairs(self.points) do
			gohelper.destroy(v.go)
		end
	end

	self._simagehero:UnLoadImage()
	self._simagesignature:UnLoadImage()
	self._simagenohero:UnLoadImage()

	self.go = nil
end

return Activity114MeetItem
