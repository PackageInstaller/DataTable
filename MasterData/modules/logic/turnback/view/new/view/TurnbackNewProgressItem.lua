-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewProgressItem.lua

module("modules.logic.turnback.view.new.view.TurnbackNewProgressItem", package.seeall)

local TurnbackNewProgressItem = class("TurnbackNewProgressItem", LuaCompBase)

function TurnbackNewProgressItem:init(go)
	self.go = go
end

function TurnbackNewProgressItem:addEventListeners()
	return
end

function TurnbackNewProgressItem:removeEventListeners()
	if self.index == 1 or self._isJump == true then
		self._btnactivity:RemoveClickListener()
	end
end

function TurnbackNewProgressItem:initItem(index)
	self.index = index

	if self.index == 1 then
		self:initMainActivity()
	else
		self:initNormalItem()
	end
end

function TurnbackNewProgressItem:initMainActivity()
	self._btnactivity = gohelper.findChildButton(self.go, "#btn_activity")

	self._btnactivity:AddClickListener(self._onClickMainActivity, self)

	self.txttitle = gohelper.findChildText(self.go, "titlebg/#txt_title")
	self.txttitle.text = TurnbackConfig.instance:getDropCoById(1).name
end

function TurnbackNewProgressItem:initNormalItem()
	self.goprogress = gohelper.findChild(self.go, "progress")
	self.gounfinish = gohelper.findChild(self.go, "progress/unfinish")
	self.txtunfinish = gohelper.findChildText(self.go, "progress/unfinish/#txt_progress")
	self.imgunfinish = gohelper.findChildImage(self.go, "progress/unfinish/bg/fill")
	self.gofinished = gohelper.findChild(self.go, "progress/finished")
	self.simagepic = gohelper.findChildSingleImage(self.go, "#simage_pic")
	self._btnactivity = gohelper.findChildButton(self.go, "#btn_activity")
	self._gojumpicon = gohelper.findChild(self.go, "icon")
end

function TurnbackNewProgressItem:_onClickMainActivity()
	local controller = VersionActivityFixedHelper.getVersionActivityEnterController().instance

	controller:openVersionActivityEnterView()
end

function TurnbackNewProgressItem:refreshItem(mo)
	self.mo = mo
	self.config = self.mo.co
	self._isJump = false

	local isJump = not string.nilorempty(self.config.jumpId)

	self.simagepic:LoadImage(ResUrl.getTurnbackIcon("new/progress/" .. self.config.picPath))

	self.txttitle = gohelper.findChildText(self.go, "titlebg/#txt_title")
	self.txttitle.text = self.config.name

	gohelper.setActive(self._btnactivity.gameObject, isJump)
	gohelper.setActive(self._gojumpicon, self.config.type == TurnbackEnum.DropType.Jump)
	gohelper.setActive(self.goprogress, self.config.type == TurnbackEnum.DropType.Progress)

	if isJump then
		self._btnactivity:AddClickListener(self._btnclickOnClick, self)

		self._isJump = true
	end

	if self.config.type == TurnbackEnum.DropType.Progress then
		if self.mo then
			local notFinish = true

			notFinish = self.mo.progress

			if self.mo.progress then
				if self.mo.progress >= 1 then
					notFinish = false
				end

				gohelper.setActive(self.gounfinish, notFinish)
				gohelper.setActive(self.gofinished, not notFinish)

				if notFinish then
					local progress = math.floor(self.mo.progress * 100) / 100

					self.txtunfinish.text = progress * 100 .. "%"
					self.imgunfinish.fillAmount = self.mo.progress
				end
			end
		end
	end
end

function TurnbackNewProgressItem:refreshItemBySelf()
	if self.index > 1 then
		local mo = TurnbackModel.instance:getDropInfoByType(self.config.id)

		if mo then
			self:refreshItem(mo)
		end
	end
end

function TurnbackNewProgressItem:_btnclickOnClick()
	local taskId = TurnbackController.instance:getProgressTaskId()

	TurnbackRpc.instance:sendFinishReadTaskRequest(taskId)
	StatController.instance:track(StatEnum.EventName.ReflowActivityJump, {
		[StatEnum.EventProperties.TurnbackJumpName] = self.config.name,
		[StatEnum.EventProperties.TurnbackJumpId] = tostring(self.config.id)
	})
	GameFacade.jump(self.config.jumpId)
end

function TurnbackNewProgressItem:onDestroy()
	return
end

return TurnbackNewProgressItem
