-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mail/view/MailViewPresentor.lua

module("logic.extensions.mail.view.MailViewPresentor", package.seeall)

local M = class("MailboxViewViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Mail_mailbox_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, MailView.New())

	local titleView = TitleView.New(CommEnum.ManualKey.Mail)

	titleView:setHideHomeBtn(true)
	table.insert(views, titleView)

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)

	return views
end

function M:onClickOutside()
	return
end

return M
