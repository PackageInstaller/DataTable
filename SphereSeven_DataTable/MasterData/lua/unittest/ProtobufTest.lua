--[[
local common_pb = require "Net.Protol.test_common_pb"
local person_pb = require "Net.Protol.test_person_pb"

function Decoder(pb_data)
	local msg = person_pb.Person()
	msg:ParseFromString(pb_data)
	--tostring 不会打印默认值
	assert(tonumber(msg.header.cmd) == 10010, 'msg.header.cmd')
	assert(msg.header.seq == 1, 'msg.header.cmd')
	assert(tonumber(msg.id) == 1223372036854775807, 'msg.id')
	assert(msg.name == 'foo', 'msg.name')
	assert(msg.array[1] == 1, 'msg.array[1]')
	assert(msg.array[2] == 2, 'msg.array[2]')
	assert(msg.age == 18, 'msg.age')
	assert(msg.email == 'topameng@qq.com',  'msg.email')
	assert(msg.Extensions[person_pb.Phone.phones][1].num == '13788888888', 'msg.Extensions.num')
	assert(msg.Extensions[person_pb.Phone.phones][1].type == person_pb.Phone.MOBILE, 'msg.Extensions.type')		
end

function Encoder()
	local msg = person_pb.Person()                                 
	msg.header.cmd = 10010                                
	msg.header.seq = 1
	msg.id = '1223372036854775807'
	msg.name = 'foo'              
	--数组添加                              
	msg.array:append(1)                              
	msg.array:append(2)            
	--extensions 添加
	local phone = msg.Extensions[person_pb.Phone.phones]:add()
	phone.num = '13788888888'      
	phone.type = person_pb.Phone.MOBILE 
	return msg:SerializeToString()
end
		
local function Run()
	local pb_data = Encoder()
	Decoder(pb_data)
end

return {
	Run = Run
}
--]]

--local pb = require 'pb'
--local protoc = require 'protoc'

local function Run()
	
	--assert(protoc:load [[
	--[[	syntax = "proto3";
        message Phone {
            string name        = 1;
            int64  phonenumber = 2;
        }
        message Person {
            string name     = 1;
            int32  age      = 2;
            string address  = 3;
            repeated Phone  contacts = 4;
        }--]]
    --]])
	--[[
	local data = {
		name = 'ilse',
		age  = 18,
		contacts = {
			{ name = 'alice', phonenumber = 12312341234 },
			{ name = 'bob',   phonenumber = 45645674567 }
		}
	}

	local bytes = assert(pb.encode('Person', data))
	print(pb.tohex(bytes))

	local data2 = assert(pb.decode('Person', bytes))
	print(data2.name)
	print(data2.age)
	print(data2.address)
	print(data2.contacts[1].name)
	print(data2.contacts[1].phonenumber)
	print(data2.contacts[2].name)
	print(data2.contacts[2].phonenumber)
	--]]

	--print("1111111111")
	--[[
	coroutine.start(function()
		coroutine.waituntil(ResourcesManager:GetInstance():CoLoadAsync("Pb/OuterMessage.pb.bytes", typeof(CS.UnityEngine.TextAsset)))
		
		print("2222222222")
		assert(pb.load(pbta.bytes))

		local C2R_Login = {
			Username = "daiyc",
			Password = "123456"
		}
		print("5555555555555555555")
		print(table.dump(pb))

		local bytes = assert(pb.encode("ETModel.C2R_Login",C2R_Login));
		print(pb.tohex(bytes))

		local data = assert(pb.decode('ETModel.C2R_Login', bytes))
		print(data.Username)
		print(data.Password)
		
	end)--]]
	
	
	--[[
	ResourcesManager:GetInstance():LoadAsync("Pb/OuterMessage.pb.bytes", typeof(CS.UnityEngine.TextAsset),function(pbta, ...)
		print("2222222222")
		assert(pb.load(pbta.bytes))

		local C2R_Login = {
			Username = "daiyc",
			Password = "123456"
		}
		print("5555555555555555555")
		print(table.dump(pb))

		local bytes = assert(pb.encode("ETModel.C2R_Login",C2R_Login));
		print(pb.tohex(bytes))

		local data = assert(pb.decode('ETModel.C2R_Login', bytes))
		print(data.Username)
		print(data.Password)
	end)
	--]]
end

return {
	Run = Run
}