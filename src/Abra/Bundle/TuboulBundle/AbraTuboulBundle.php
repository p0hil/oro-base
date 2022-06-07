<?php

namespace Abra\Bundle\TuboulBundle;

use Abra\Bundle\TuboulBundle\DependencyInjection\AbraTuboulExtension;
use Symfony\Component\HttpKernel\Bundle\Bundle;

class AbraTuboulBundle extends Bundle
{
    public function getContainerExtension()
    {
        $this->extension = parent::getContainerExtension();
        if (!$this->extension) {
            $this->extension = new AbraTuboulExtension();
        }

        return $this->extension;
    }


}
