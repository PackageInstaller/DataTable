-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_ItemDescLinkHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_ItemDescLinkHelper", package.seeall)

local Rouge2_ItemDescLinkHelper = class("Rouge2_ItemDescLinkHelper")

Rouge2_ItemDescLinkHelper.LinkType = {
	Attr = 1,
	System = 2
}

function Rouge2_ItemDescLinkHelper.addLink(desc)
	if string.nilorempty(desc) then
		return
	end

	desc = string.gsub(desc, "%@(.-)%@", Rouge2_ItemDescLinkHelper._replaceLinkInfo)

	return SkillHelper.addLink(desc)
end

function Rouge2_ItemDescLinkHelper._replaceLinkInfo(info)
	Rouge2_ItemDescLinkHelper._initLinkHandleFunc()

	local infoList = string.split(info, ":") or {}
	local linkType = infoList and tonumber(infoList[1])
	local handleFunc = Rouge2_ItemDescLinkHelper._linkType2HandleFuncMap[linkType]

	if not handleFunc then
		logError(string.format("肉鸽文本解析类型不存在 linkType = %s, str = %s", linkType, info))

		return ""
	end

	table.remove(infoList, 1)

	return handleFunc(infoList)
end

function Rouge2_ItemDescLinkHelper._initLinkHandleFunc()
	if not Rouge2_ItemDescLinkHelper._linkType2HandleFuncMap then
		Rouge2_ItemDescLinkHelper._linkType2HandleFuncMap = {}
		Rouge2_ItemDescLinkHelper._linkType2HandleFuncMap[Rouge2_ItemDescLinkHelper.LinkType.Attr] = Rouge2_ItemDescLinkHelper._attrHandleFunc
		Rouge2_ItemDescLinkHelper._linkType2HandleFuncMap[Rouge2_ItemDescLinkHelper.LinkType.System] = Rouge2_ItemDescLinkHelper._systemHandleFunc
	end
end

function Rouge2_ItemDescLinkHelper._attrHandleFunc(infoList)
	local attrId = infoList and tonumber(infoList[1])

	if attrId then
		::label_4_0::

		local attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(attrId)

		if not attrCo then
			logError(string.format("肉鸽文本描述中属性配置不存在 attrId = %s", attrId))

			return ""
		end

		return string.format("<sprite=%s>", attrCo.spriteIndex)
	end
end

function Rouge2_ItemDescLinkHelper._systemHandleFunc(infoList)
	local systemId = infoList and tonumber(infoList[1])

	if systemId then
		::label_5_0::

		local systemCo = Rouge2_CareerConfig.instance:getSystemConfig(systemId)
		local battleTagCo = Rouge2_CareerConfig.instance:getBattleTagConfigBySystemId(systemId)

		if not systemCo or not battleTagCo then
			logError(string.format("肉鸽文本描述中体系配置不存在 systemId = %s", systemId))

			return ""
		end

		return battleTagCo and battleTagCo.tagName
	end
end

return Rouge2_ItemDescLinkHelper
