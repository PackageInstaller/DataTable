RecollectionsSweepstakeLayer = class("RecollectionsSweepstakeLayer", (require("view.Layer.BaseUILayer")))

local time_check_manager = require("controller.time_check_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_3 = "RecollectionsSweepstakeLayer/"
local RichTextPro = require("view.Sprite.RichTextPro")
local share_manager = require("controller.share_manager")

function RecollectionsSweepstakeLayer:ctor()
	RecollectionsSweepstakeLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.recollections.recollections_sweepstake_manager"):getInstance()
end

function RecollectionsSweepstakeLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = RecollectionsSweepstakeLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function RecollectionsSweepstakeLayer.onEnter(arg_3_0)
	RecollectionsSweepstakeLayer.super.onEnter(arg_3_0)
end

function RecollectionsSweepstakeLayer.onExit(arg_4_0)
	RecollectionsSweepstakeLayer.super.onExit(arg_4_0)
end

function RecollectionsSweepstakeLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function RecollectionsSweepstakeLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:_setBack()
	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	TempWidget:CreateTempImg(var_0_3 .. "bg.png", var_6_0):align(cc.p(0.5, 0), var_6_0:property().top_bottom)

	local var_6_1 = TempWidget:CreateTempListView(var_6_0)

	var_6_1:setContentSize(cc.size(var_6_0:size().w, var_6_0:size().h - 630))

	self.listView = var_6_1

	self:initListView()

	local var_6_2 = TempWidget:CreateTempImg(var_0_3 .. "accomplishment.png", var_6_0)

	var_6_2:align(cc.p(0.5, 1), var_6_0:size().w / 2, var_6_0:size().h + 300)
	var_6_2:runAction(cc.EaseBackOut:create(cc.MoveTo:create(0.5, cc.p(var_6_0:size().w / 2, var_6_0:size().h - 20))))

	local var_6_3 = TempWidget:CreateTempImg(var_0_3 .. "display_bg.png", var_6_2)

	var_6_3:align(cc.p(0.5, 1), var_6_2:size().w / 2, -10)

	local var_6_4 = self.manager:getTitleStrinfo()
	local var_6_5 = TempWidget:CreateTempLabel(var_6_4.title, FONT_W5, 48, var_6_3)

	var_6_5:_setColor("071744")
	var_6_5:align(cc.p(0.5, 1), var_6_3:size().w / 2, var_6_3:size().h - 25)

	local var_6_6 = TempWidget:CreateTempLabel(var_6_4.body, FONT_W5, 24, var_6_3)

	var_6_6:setMaxLineWidth(var_6_3:size().w - 145)
	var_6_6:_setColor("071744")
	var_6_6:align(cc.p(0.5, 1), var_6_3:size().w / 2, var_6_5:pos().y - var_6_5:size().h - 20)
	var_6_6:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)

	local var_6_7 = TempWidget:CreateTempImg(var_0_3 .. "redemption_code.png", var_6_2)

	var_6_7:align(cc.p(0.5, 1), var_6_2:size().w / 2, var_6_3:pos().y - var_6_3:size().h - 10)

	local var_6_8 = TempWidget:CreateTempImg(var_0_3 .. "display_bg.png", var_6_2)

	var_6_8:align(cc.p(0.5, 1), var_6_2:size().w / 2, var_6_7:pos().y - var_6_7:size().h - 10)

	local var_6_9 = TempWidget:CreateTempLabel(self.manager:getRedemptionCode(), FONT_W5, 48, var_6_8)

	var_6_9:_setColor("071744")
	var_6_9:align(cc.p(0.5, 0.5), var_6_8:property().center)

	local var_6_10 = TempWidget:CreateTempBtn(var_0_3 .. "look_again_btn.png", var_6_2)

	var_6_10:align(cc.p(0.5, 1), var_6_2:size().w / 2 - 200, var_6_8:pos().y - var_6_8:size().h - 20)

	self.lookAgainBtn = var_6_10

	local var_6_11 = TempWidget:CreateTempBtn(var_0_3 .. "local_save.png", var_6_2)

	var_6_11:align(cc.p(0.5, 1), var_6_2:size().w / 2, var_6_8:pos().y - var_6_8:size().h - 20)

	self.saveLocalBtn = var_6_11

	local var_6_12 = TempWidget:CreateTempBtn(var_0_3 .. "share_btn.png", var_6_2)

	var_6_12:align(cc.p(0.5, 1), var_6_2:size().w / 2 + 200, var_6_8:pos().y - var_6_8:size().h - 20)

	self.shareBtn = var_6_12

	if not share_manager.doShare then
		var_6_12:hide()
	end

	local var_6_13 = TempWidget:CreateTempImg(var_0_3 .. "first_share.png", var_6_12)

	var_6_13:align(cc.p(0.5, 0), var_6_12:size().w / 2 + 10, var_6_12:size().h)

	self.firstShareImg = var_6_13

	self:updateFirstShareImgVisible()
	TempWidget:CreateTempImg(var_0_3 .. "bottom_shadow.png", var_6_0):align(cc.p(0.5, 0), var_6_0:size().w / 2, 0)

	local var_6_14 = TempWidget:CreateTempBtn(var_0_3 .. "back.png", var_6_0)

	var_6_14:align(cc.p(0, 0), -var_6_14:size().w, 10)
	var_6_14:runAction(cc.EaseBackOut:create(cc.MoveTo:create(0.5, cc.p(10, 10))))

	self.backBtn = var_6_14
end

function RecollectionsSweepstakeLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
	self.backBtn:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end, {
		touchDelay = 0.5
	})
	self.lookAgainBtn:_addEvent(function()
		if self.manager:isRegister() then
			LayerManager:removePopLayer()
			LayerManager:pushInLayer("RecollectionsLayer")
		else
			global_ShowBlockWords("班长在学院的故事才刚刚开始哟~")
		end
	end, {
		touchDelay = 0.5
	})
	self.saveLocalBtn:_addEvent(function()
		if not self.manager:isRegister() then
			global_ShowBlockWords("班长在学院的故事才刚刚开始哟~")

			return
		end

		self:saveLocal()
	end, {
		touchDelay = 0.5
	})

	if not share_manager.doShare then
		self.saveLocalBtn:move(cc.p(self.shareBtn:getPosition()))
	end

	self.shareBtn:_addEvent(function()
		if not self.manager:isRegister() then
			global_ShowBlockWords("班长在学院的故事才刚刚开始哟~")

			return
		end

		local var_12_0 = self:createShareLayout()

		var_12_0:move(0, self._root:size().h)
		var_12_0:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(0, 0)), cc.CallFunc:create(function()
			var_12_0:_addEvent(function()
				var_12_0:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(0, self._root:size().h)), cc.RemoveSelf:create()))
			end)
			self:channelSharing()
		end)))
	end, {
		touchDelay = 0.5
	})
end

function RecollectionsSweepstakeLayer:initListView()
	self.listView:setItemsMargin(20)

	local var_15_0 = TempWidget:CreateTempImg(var_0_3 .. "award_show.png")
	local var_15_1 = TempWidget:CreateTempLayout()

	var_15_1:setContentSize(cc.size(self.listView:size().w, var_15_0:size().h))
	var_15_1:addChild(var_15_0)
	var_15_0:align(cc.p(0.5, 0), var_15_1:size().w / 2, 0)
	self.listView:pushBackCustomItem(var_15_1)

	local var_15_2 = TempWidget:CreateTempImg(var_0_3 .. "details.png")
	local var_15_3 = TempWidget:CreateTempLayout()

	var_15_3:setContentSize(cc.size(self.listView:size().w, var_15_2:size().h))
	var_15_3:addChild(var_15_2)
	var_15_2:align(cc.p(0.5, 0), var_15_3:size().w / 2, 0)
	self.listView:pushBackCustomItem(var_15_3)

	local var_15_4 = TempWidget:CreateTempLabel(self.manager:getDetailsStr(), FONT_NAME, 30)

	var_15_4:setMaxLineWidth(self.listView:size().w - 150)

	local var_15_5 = TempWidget:CreateTempLayout()

	var_15_5:setContentSize(cc.size(self.listView:size().w, var_15_4:size().h))
	var_15_5:addChild(var_15_4)
	var_15_4:align(cc.p(0.5, 0), var_15_5:size().w / 2, 0)
	self.listView:pushBackCustomItem(var_15_5)

	local var_15_6 = TempWidget:CreateTempLayout()

	var_15_6:setContentSize(cc.size(self.listView:size().w, TempWidget:CreateTempBtn(var_0_3 .. "back.png"):size().h + 10))
	self.listView:pushBackCustomItem(var_15_6)
end

function RecollectionsSweepstakeLayer.updateLayer(arg_16_0)
	return
end

function RecollectionsSweepstakeLayer.updateRed(arg_17_0)
	return
end

function RecollectionsSweepstakeLayer:createShareLayout()
	self._root:removeChildByName("shareLayout")

	local var_18_0 = TempWidget:CreateTempLayout(self._root)

	var_18_0:setLocalZOrder(10)
	var_18_0:_addEvent(function()
		return
	end)
	var_18_0:setContentSize(self._root:size())
	var_18_0:_setBack()
	var_18_0:setName("shareLayout")
	TempWidget:CreateTempImg(var_0_3 .. "share_bg.png", var_18_0):align(cc.p(0.5, 0), var_18_0:property().top_bottom)

	local var_18_1 = TempWidget:CreateTempImg(var_0_3 .. "accomplishment.png", var_18_0)

	var_18_1:align(cc.p(0.5, 1), var_18_0:size().w / 2, var_18_0:size().h - 20)

	local var_18_2 = TempWidget:CreateTempImg(var_0_3 .. "share_title_bg.png", var_18_0)

	var_18_2:align(cc.p(0.5, 1), var_18_0:size().w / 2, var_18_1:pos().y - var_18_1:size().h - 10)

	local var_18_3 = self.manager:getTitleStrinfo()
	local var_18_4 = TempWidget:CreateTempLabel(var_18_3.title, FONT_W5, 48, var_18_2)

	var_18_4:_setColor("071744")
	var_18_4:align(cc.p(0.5, 1), var_18_2:size().w / 2, var_18_2:size().h - 10)

	local var_18_5 = TempWidget:CreateTempLabel(var_18_3.body, FONT_W5, 24, var_18_2)

	var_18_5:setMaxLineWidth(var_18_2:size().w - 120)
	var_18_5:_setColor("071744")
	var_18_5:align(cc.p(0.5, 1), var_18_2:size().w / 2, var_18_4:pos().y - var_18_4:size().h - 10)

	local var_18_6 = RichTextPro:create()

	var_18_6:setMaxWidth(var_18_0:size().w)
	var_18_6:setText((self.manager:getShareStr()))
	var_18_6:setPosition(cc.p(10, var_18_2:pos().y - var_18_2:size().h - 10))
	var_18_0:addChild(var_18_6)
	TempWidget:CreateTempImg(var_0_3 .. "logo.png", var_18_0):align(cc.p(0.5, 0), var_18_0:size().w / 2, 0)

	return var_18_0
end

function RecollectionsSweepstakeLayer.channelSharing(arg_20_0)
	cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("cleanTouchEffect"))

	local var_20_0 = time_check_manager:getCurTime()

	cc.utils:captureScreen(function(arg_21_0, arg_21_1)
		if arg_21_0 then
			arg_20_0.backBtn:setLocalZOrder(arg_20_0.listView:getLocalZOrder() + 1)
			cc.Director:getInstance():getTextureCache():removeTextureForKey(arg_21_1)

			if not share_manager:can_share() then
				global_ShowBlockWords("无法分享")

				return
			end

			share_manager:registerShareHandler(function(arg_22_0)
				if arg_22_0 == 0 then
					global_ShowBlockWords("分享成功")
					arg_20_0.manager:shareSuccess()
				end
			end)

			if share_manager.doShare then
				share_manager:doShare("标题", arg_21_1, "内容")
			end
		end
	end, cc.FileUtils:getInstance():getWritablePath() .. "Horcrux_Recollections_CaptureScreen_Share.png")
end

function RecollectionsSweepstakeLayer:shareSuccess()
	self._root:removeChildByName("shareLayout")
	self:updateFirstShareImgVisible()
end

function RecollectionsSweepstakeLayer:saveLocal()
	local var_24_0 = self:createShareLayout()

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("cleanTouchEffect"))
	cc.utils:captureScreen(function(arg_25_0, arg_25_1)
		if arg_25_0 then
			self.manager:saveTrigger()
			self.backBtn:setLocalZOrder(self.listView:getLocalZOrder() + 1)

			if cc.Native.imageWriteToPhotosAlbum then
				if DeviceManager.platform == "android" then
					cc.Native:imageWriteToPhotosAlbum(arg_25_1, "HorcruxRecollections" .. os.date("%Y%m%d") .. ".png")
				else
					cc.Native:imageWriteToPhotosAlbum(arg_25_1)
				end
			end

			global_ShowBlockWords("保存成功")
			var_24_0:align(cc.p(0.5, 0.5), self._root:property().center)

			local var_25_0 = {}

			table.insert(var_25_0, (cc.Spawn:create(cc.ScaleTo:create(0.2, 0.2), cc.MoveTo:create(0.2, cc.p(self._root:size().w - var_24_0:getContentSize().width * 0.2 / 2 - 10, self._root:size().h - var_24_0:getContentSize().height * 0.2 / 2 - 25)))))
			table.insert(var_25_0, (cc.DelayTime:create(0.2)))

			local var_25_1 = cc.MoveBy:create(2, cc.p(0, 10))

			table.insert(var_25_0, (cc.Spawn:create(cc.Repeat:create(cc.Sequence:create(var_25_1, (var_25_1:reverse())), 4), (cc.Sequence:create(cc.DelayTime:create(4 * 2 - 1), cc.FadeOut:create(1), (cc.CallFunc:create(function()
				self._root:removeChildByName("shareLayout")
			end)))))))
			var_24_0:runAction((cc.Sequence:create(var_25_0)))
			var_24_0:_addEvent(function()
				var_24_0:stopAllActions()
				var_24_0:setOpacity(255)
				var_24_0:runAction(cc.Spawn:create(cc.ScaleTo:create(0.2, 1), cc.MoveTo:create(0.2, cc.p(self._root:size().w / 2, self._root:size().h / 2))))
				var_24_0:_addEvent(function()
					var_24_0:runAction(cc.RemoveSelf:create())
				end)
			end)
		end
	end, cc.FileUtils:getInstance():getWritablePath() .. "Horcrux_Recollections_CaptureScreen_Share.png")
end

function RecollectionsSweepstakeLayer:updateFirstShareImgVisible()
	self.firstShareImg:setVisible(not self.manager:isShare())
end

return RecollectionsSweepstakeLayer
