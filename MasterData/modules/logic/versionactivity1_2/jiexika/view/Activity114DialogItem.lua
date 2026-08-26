-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114DialogItem.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114DialogItem", package.seeall)

local Activity114DialogItem = class("Activity114DialogItem", Activity114DialogBaseItem)
local stepCo = {
	1,
	"",
	{
		1,
		{
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1
		},
		false,
		0,
		0,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		1,
		{},
		true,
		false,
		{
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			""
		},
		false,
		"",
		0,
		{
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			""
		},
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3
		}
	},
	{},
	{
		0,
		"",
		0,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
			0.5,
			0.5,
			0.5,
			0.5,
			0.5,
			0.5,
			0.5,
			0.5
		},
		0,
		0,
		0,
		1,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		0,
		0,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		1
	},
	{},
	{},
	{},
	{},
	{},
	{},
	{
		{
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			""
		},
		{
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			""
		},
		{
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			""
		}
	},
	{
		0,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	}
}
local stepMo = StoryStepMo.New()

function Activity114DialogItem:showTxt(txt, endCallBack, callObj)
	gohelper.setActive(self._conGo, true)

	stepCo[3][15][1] = txt

	stepMo:init(stepCo)

	self._endCallBack = endCallBack
	self._endCallObj = callObj

	self:playDialog(txt, stepMo)
end

function Activity114DialogItem:skipDialog()
	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	self:conFinished()
end

function Activity114DialogItem:conFinished(...)
	if self._endCallBack then
		self._endCallBack(self._endCallObj)
	end

	Activity114DialogItem.super.conFinished(self, ...)
end

return Activity114DialogItem
