define chain
$(eval __chain_name    := $1)
$(eval __chain_targets := $2)
$(eval __chain_last_target :=)
$(foreach target, $(__chain_targets),
  $(eval __chain_target := $(target)$(__chain_name))
  $(eval .PHONY: $(__chain_target))
  $(eval $(__chain_target): $(__chain_last_target))
  $(eval __chain_last_target := $(__chain_target))
)
$(eval .PHONY: $(__chain_name))
$(eval $(__chain_name): $(__chain_last_target))
endef

$(foreach chain_name, $(filter-out @D @F, $(filter @%, $(.VARIABLES))), \
  $(call chain, $(chain_name), $($(chain_name))) \
)
