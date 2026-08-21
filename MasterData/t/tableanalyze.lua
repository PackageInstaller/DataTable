function GetLuamonoInSpertorString(obj)
    local str = ""
    local function Foreach(t,level,name)
	   for key,value in pairs(t) do
            if key ~= "RefTable" and key ~= "__index" and key ~= "super" and key ~= "class" then
                if type(value) == "table" then          
                    str = str.."table_"..key.."|"..name.."_"..key.."_"..level.."*"
                    Foreach(value,level + 1,name.."."..key)
                else
                    if type(value) ~= "userdata" and type(value) ~= "function" and type(value) ~= "boolean" then
                        str = str..type(value).."_"..key.."|"..name.."_"..value.."_"..level.."*"
                    end
                end 
            end
    	end
    end
    Foreach(obj,1,"reftable")
    return str
end  