-- chunkname: @modules/logic/common/view/FixTmpBreakLine.lua

module("modules.logic.common.view.FixTmpBreakLine", package.seeall)

local FixTmpBreakLine = class("FixTmpBreakLine", LuaCompBase)

function FixTmpBreakLine:initData(txtComp)
	self.textMeshPro = txtComp.gameObject:GetComponent(typeof(TMPro.TextMeshProUGUI))

	if self.textMeshPro then
		self.textMeshPro.richText = true
	end
end

function FixTmpBreakLine:refreshTmpContent(txtComp)
	if not txtComp then
		return
	end

	self:initData(txtComp)

	local content = self.textMeshPro.text

	if not self:startsWith(content, "<nobr>") then
		content = string.format("<nobr>%s", content)
	end

	content = string.gsub(content, " +", function(match)
		return "<space=" .. string.len(match) * ZProj.GameHelper.GetTmpCharWidth(self.textMeshPro, 32) .. ">"
	end)
	self.textMeshPro.text = content

	self.textMeshPro:Rebuild(UnityEngine.UI.CanvasUpdate.PreRender)
end

function FixTmpBreakLine:startsWith(content, str)
	return string.sub(content, 1, string.len(str)) == str
end

return FixTmpBreakLine
