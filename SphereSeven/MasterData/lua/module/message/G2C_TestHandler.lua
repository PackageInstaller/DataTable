---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/4/10 14:15
---

local G2C_TestHandler = BaseClass("G2C_TestHandler",IMHandler)

G2C_TestHandler.Handle = function(self,pbMsg)
    print("G2C_TestHandler.Handle be called:"..cjson.encode(pbMsg))
end

return G2C_TestHandler