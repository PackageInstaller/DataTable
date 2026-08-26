-- chunkname: @modules/ugui/textmeshpro/TMPMarkTopHelper.lua

module("modules.ugui.textmeshpro.TMPMarkTopHelper", package.seeall)

local Type_TMPMark = typeof(ZProj.TMPMark)

function TMPMarkTopHelper.init(gameObject)
	local _txtmarktop = IconMgr.instance:getCommonTextMarkTop(gameObject):GetComponent(gohelper.Type_TextMesh)
	local _conMark = gohelper.onceAddComponent(gameObject, Type_TMPMark)

	_conMark:SetMarkTopGo(_txtmarktop.gameObject)
	_conMark:SetTopOffset(0, -2)
end

function TMPMarkTopHelper.SetTextWithMarksTop(txt, curDesc)
	txt.text = StoryTool.filterMarkTop(curDesc)

	local markTopList = StoryTool.getMarkTopTextList(curDesc)
	local _conMark = txt.gameObject:GetComponent(Type_TMPMark)

	TaskDispatcher.runDelay(function()
		if _conMark then
			_conMark:SetMarksTop(markTopList)
		end
	end, nil, 0.01)
end

return TMPMarkTopHelper
