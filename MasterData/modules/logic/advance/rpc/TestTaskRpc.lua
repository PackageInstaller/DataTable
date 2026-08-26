-- chunkname: @modules/logic/advance/rpc/TestTaskRpc.lua

module("modules.logic.advance.rpc.TestTaskRpc", package.seeall)

local TestTaskRpc = class("TestTaskRpc", BaseRpc)

TestTaskRpc.instance = TestTaskRpc.New()

return TestTaskRpc
