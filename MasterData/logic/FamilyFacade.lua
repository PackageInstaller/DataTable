-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/facade/FamilyFacade.lua

module("logic.extensions.family.facade.FamilyFacade", package.seeall)

local FamilyFacade = class("FamilyFacade", BaseFacade)

function FamilyFacade:ctor()
	return
end

function FamilyFacade:updateFamilyTag(container, tag)
	local txtTag = goutil.findChildTextComponent(container, "text")
	local txtColorChange = txtTag:GetComponent("UITextColorChange")

	if txtColorChange then
		txtColorChange:SetState(tag)
	end

	txtTag.text = lang("tip_family_purpose_" .. tag + 1)
end

function FamilyFacade:getFamilyTagText(settingInfo, separation)
	if settingInfo == nil then
		return ""
	end

	local text = ""
	local t = {}

	if checknumber(settingInfo.maxZdlLimit) > 0 then
		table.insert(t, string.format("战力%sW", checknumber(settingInfo.maxZdlLimit) / 10000))
	end

	if checknumber(settingInfo.playerLevelLimit) > 0 then
		table.insert(t, string.format("等级%s", checknumber(settingInfo.playerLevelLimit)))
	end

	if #t < 2 then
		table.insert(t, settingInfo.needApproval and "需审批" or "不需审批")
	end

	for k, v in ipairs(t) do
		text = k == 1 and text .. v or string.format("%s%s%s", text, separation, v)
	end

	return text
end

FamilyFacade.instance = FamilyFacade.New()

return FamilyFacade
