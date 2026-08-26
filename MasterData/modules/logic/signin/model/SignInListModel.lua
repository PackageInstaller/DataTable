-- chunkname: @modules/logic/signin/model/SignInListModel.lua

module("modules.logic.signin.model.SignInListModel", package.seeall)

local SignInListModel = class("SignInListModel", ListScrollModel)

function SignInListModel:setPropList(Infos)
	self._moList = Infos and Infos or {}

	self:setList(self._moList)
end

function SignInListModel:clearPropList()
	self._moList = nil

	self:clear()
end

SignInListModel.instance = SignInListModel.New()

return SignInListModel
