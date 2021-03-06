#    This file is part of Metasm, the Ruby assembly manipulation suite
#    Copyright (C) 2006-2009 Yoann GUILLOT
#
#    Licence is LGPL, see LICENCE in the top-level directory


require 'metasm/main'

module Metasm
class OpenRisc < CPU
	class Reg
		attr_accessor :v
		def initialize(v)
			@v = v
		end

		def symbolic(di=nil) ; "r#@v".to_sym ; end
	end

	class MemRef
		attr_accessor :base, :offset, :msz

		def initialize(base, offset, msz)
			@base = base
			@offset = offset
			@msz = msz
		end

		def symbolic(di)
			p = Expression[@base.symbolic] if base
			p = Expression[p, :+, @offset] if offset
			Indirection[p, @msz, (di.address if di)]
		end
	end

	def initialize(family = :latest, endianness = :big, delay_slot = 1)
		super()
		@endianness = endianness
		@size = 32
		@family = family
		@delay_slot = delay_slot
	end

	def init_opcode_list
		send("init_#@family")
		@opcode_list
	end

	def delay_slot(di=nil)
		@delay_slot
	end
end
end

