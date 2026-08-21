-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/EchoGyrosTestPresentor.lua

module("logic.extensions.charactersystem.view.carrier.EchoGyrosTestPresentor", package.seeall)

local M = class("EchoGyrosTestPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Carryitem_echo_gyros_test
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EchoGyrosTest.New())

	return views
end

return M
