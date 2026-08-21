local M = Util.create_class()

function M:_init()
end

function M:get_story_text(language_id)
  return M:get_info(language_id, "story_language")
end

function M:get_text(language_id)
  return M:get_info(language_id, "multilingual")
end

function M:get_code_text(language_id)
  return M:get_info(language_id, "code_language")
end

function M:get_info(language_id, file_name)
  if not language_id then
    return nil
  end
  local config_name = "multilingual.{1}_{2}"
  local info = ShareRes.create(Util.format_str(config_name, file_name, Global.curr_text_language), language_id)
  if not info and SDKType == Config.SDK_TYPE.HIVE_SDK then
    info = ShareRes.create(Util.format_str(config_name, file_name, "EN"), language_id)
  end
  info = info or ShareRes.create(Util.format_str(config_name, file_name, Global.default_language), language_id)
  if not info then
    return language_id
  end
  return info
end

return M
